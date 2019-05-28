/* This file is part of VoltDB.
 * Copyright (C) 2008-2019 VoltDB Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with VoltDB.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.voltdb.compiler.statements;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.regex.Matcher;

import org.hsqldb_voltpatches.FunctionForVoltDB;
import org.hsqldb_voltpatches.VoltXMLElement;
import org.voltcore.utils.CoreUtils;
import org.voltdb.VoltType;
import org.voltdb.catalog.Database;
import org.voltdb.compiler.DDLCompiler;
import org.voltdb.compiler.DDLCompiler.DDLStatement;
import org.voltdb.compiler.ProcedureCompiler;
import org.voltdb.compiler.VoltCompiler.DdlProceduresToLoad;
import org.voltdb.compiler.VoltCompiler.VoltCompilerException;
import org.voltdb.parser.SQLParser;

/**
 * Process CREATE AGGREGATE FUNCTION <function-name> FROM CLASS <class-name>
 */
public class CreateAggregateFunctionFromClass extends CreateFunction {

    public CreateAggregateFunctionFromClass(DDLCompiler ddlCompiler) {
        super(ddlCompiler);
    }

    @Override
    protected boolean processStatement(DDLStatement ddlStatement, Database db, DdlProceduresToLoad whichProcs)
            throws VoltCompilerException {

        // Matches if it is CREATE AGGREGATE FUNCTION <name> FROM CLASS <class-name>
        Matcher statementMatcher = SQLParser.matchCreateAggregateFunctionFromClass(ddlStatement.statement);
        if (!statementMatcher.matches()) {
            return false;
        }

        // Clean up the names
        String functionName = checkIdentifierStart(statementMatcher.group(1), ddlStatement.statement).toLowerCase();
        // Class name is case sensitive.
        String className = checkIdentifierStart(statementMatcher.group(2), ddlStatement.statement);

        // Check if the function is already defined
        if (isDefinedFunctionName(functionName)) {
            throw m_compiler.new VoltCompilerException(String.format(
                    "Function \"%s\" is already defined.",
                    functionName));
        }
        // Load the function class
        Class<?> funcClass;
        try {
            funcClass = Class.forName(className, true, m_classLoader);
        }
        catch (Throwable cause) {
            // We are here because either the class was not found or the class was found and
            // the initializer of the class threw an error we can't anticipate. So we will
            // wrap the error with a runtime exception that we can trap in our code.
            if (CoreUtils.isStoredProcThrowableFatalToServer(cause)) {
                throw (Error)cause;
            }
            else {
                throw m_compiler.new VoltCompilerException(String.format(
                        "Cannot load class for user-defined aggregate function: %s",
                        className), cause);
            }
        }

        if (Modifier.isAbstract(funcClass.getModifiers())) {
            throw m_compiler.new VoltCompilerException(String.format(
                "Cannot define a aggregate function using an abstract class %s",
                className));
        }

        // get the short name of the agg class
        String shortName = ProcedureCompiler.deriveShortProcedureName(className);
        // find the four(start, assemble, combine, end) functions in the class
        Method assembleMethod = null;
        Method endMethod = null;
        boolean start = false, assemble = false, combine = false, end = false;
        for (final Method m : funcClass.getDeclaredMethods()) {
            // if this function is not one the the four, skip
            String funcName = m.getName();
            if (!funcName.equals("start") && !funcName.equals("assemble")
                && !funcName.equals("combine") && !funcName.equals("end")) {
                continue;
            }
            boolean found = true;
            StringBuilder warningMessage = new StringBuilder("function " + funcName + " is ");
            if (!Modifier.isPublic(m.getModifiers())) {
                warningMessage.append("non-public ");
                found = false;
            }
            if (Modifier.isStatic(m.getModifiers())) {
                warningMessage.append("static ");
                found = false;
            }
            // start|assemble|combine function should be void,
            // but end function cannot be void
            if (!funcName.equals("end")) {
                if (!m.getReturnType().equals(Void.TYPE)) {
                    warningMessage.append("not void ");
                    found = false;
                }
            }
            else {
                if (m.getReturnType().equals(Void.TYPE)) {
                    warningMessage.append("void ");
                    found = false;
                }
            }
            if (found) {
                // check if this function has already occurrd in the class
                switch (funcName) {
                    case "start":
                        if (start) {
                            String msg = "Class " + shortName + " has multiple methods named start";
                            throw m_compiler.new VoltCompilerException(msg);
                        }
                        start = true;
                        break;
                    
                    case "assemble":
                        if (assemble) {
                            String msg = "Class " + shortName + " has multiple methods named assemble";
                            throw m_compiler.new VoltCompilerException(msg);
                        }
                        assemble = true;
                        assembleMethod = m;
                        break;
                    
                    case "combine":
                        if (combine) {
                            String msg = "Class " + shortName + " has multiple methods named combine";
                            throw m_compiler.new VoltCompilerException(msg);
                        }
                        combine = true;
                        break;
                    
                    case "end":
                        if (end) {
                            String msg = "Class " + shortName + " has multiple methods named end";
                            throw m_compiler.new VoltCompilerException(msg);
                        }
                        end = true;
                        endMethod = m;
                        break;
                }
            }
            else {
                m_compiler.addWarn(warningMessage.toString());
            }
        }
        // check if all four functions appear in the class
        if (!(start && assemble && combine && end)) {
            String msg = "Cannot find all four functions for the class " + shortName +
                " for user-defined aggregate function " + functionName;
            throw m_compiler.new VoltCompilerException(msg);
        }

        Class<?> returnTypeClass = endMethod.getReturnType();
        if (!m_allowedDataTypes.contains(returnTypeClass)) {
            String msg = String.format("End has an unsupported return type %s",
                returnTypeClass.getName());
            throw m_compiler.new VoltCompilerException(msg);
        }

        Class<?>[] paramTypeClasses = assembleMethod.getParameterTypes();
        int paramCount = paramTypeClasses.length;
        for (int i = 0; i < paramCount; i++) {
            Class<?> paramTypeClass = paramTypeClasses[i];
            if (!m_allowedDataTypes.contains(paramTypeClass)) {
                String msg = String.format("Assmble has an unsupported parameter type %s at position %d",
                        paramTypeClass.getName(), i);
                throw m_compiler.new VoltCompilerException(msg);
            }
        }

        try {
            funcClass.newInstance();
        }
        catch (InstantiationException | IllegalAccessException e) {
            throw new RuntimeException(String.format("Error instantiating class \"%s\"", shortName), e);
        }
        VoltType voltReturnType = VoltType.typeFromClass(returnTypeClass);
        VoltType[] voltParamTypes = new VoltType[paramTypeClasses.length];
        VoltXMLElement funcXML = new VoltXMLElement("ud_function")
                                    .withValue("name", functionName)
                                    .withValue("className", className)
                                    .withValue("returnType", String.valueOf(voltReturnType.getValue()));
        for (int i = 0; i < paramTypeClasses.length; i++) {
            VoltType voltParamType = VoltType.typeFromClass(paramTypeClasses[i]);
            VoltXMLElement paramXML = new VoltXMLElement("udf_ptype")
                                         .withValue("type", String.valueOf(voltParamType.getValue()));
            funcXML.children.add(paramXML);
            voltParamTypes[i] = voltParamType;
        }
        //
        // Register the function and get the function id.  This lets HSQL use the name in
        // indexes, materialized views and tuple limit delete statements.  These are not
        // valid, but it helps us give a nice error message.  Note that this definition
        // may revive a saved user defined function, and that nothing is put into the
        // catalog here.
        //
        int functionId = FunctionForVoltDB.registerTokenForUDF(functionName, -1, voltReturnType, voltParamTypes, 'a');
        funcXML.attributes.put("functionid", String.valueOf(functionId));

        m_logger.debug(String.format("Added XML for function \"%s\"", functionName));
        m_schema.children.add(funcXML);
        return true;
    }
}
