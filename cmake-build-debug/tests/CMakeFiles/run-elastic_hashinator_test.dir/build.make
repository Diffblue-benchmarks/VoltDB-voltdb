# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/russelhu/Github/voltdb

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/russelhu/Github/voltdb/cmake-build-debug

# Utility rule file for run-elastic_hashinator_test.

# Include the progress variables for this target.
include tests/CMakeFiles/run-elastic_hashinator_test.dir/progress.make

tests/CMakeFiles/run-elastic_hashinator_test: cpptests/common/elastic_hashinator_test
	cd /Users/russelhu/Github/voltdb/cmake-build-debug/tests && /usr/bin/env CTEST_OUTPUT_ON_FAILURE=true /Applications/CLion.app/Contents/bin/cmake/mac/bin/ctest -j 4 -R elastic_hashinator_test

run-elastic_hashinator_test: tests/CMakeFiles/run-elastic_hashinator_test
run-elastic_hashinator_test: tests/CMakeFiles/run-elastic_hashinator_test.dir/build.make

.PHONY : run-elastic_hashinator_test

# Rule to build all files generated by this target.
tests/CMakeFiles/run-elastic_hashinator_test.dir/build: run-elastic_hashinator_test

.PHONY : tests/CMakeFiles/run-elastic_hashinator_test.dir/build

tests/CMakeFiles/run-elastic_hashinator_test.dir/clean:
	cd /Users/russelhu/Github/voltdb/cmake-build-debug/tests && $(CMAKE_COMMAND) -P CMakeFiles/run-elastic_hashinator_test.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/run-elastic_hashinator_test.dir/clean

tests/CMakeFiles/run-elastic_hashinator_test.dir/depend:
	cd /Users/russelhu/Github/voltdb/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/russelhu/Github/voltdb /Users/russelhu/Github/voltdb/tests/ee /Users/russelhu/Github/voltdb/cmake-build-debug /Users/russelhu/Github/voltdb/cmake-build-debug/tests /Users/russelhu/Github/voltdb/cmake-build-debug/tests/CMakeFiles/run-elastic_hashinator_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/run-elastic_hashinator_test.dir/depend

