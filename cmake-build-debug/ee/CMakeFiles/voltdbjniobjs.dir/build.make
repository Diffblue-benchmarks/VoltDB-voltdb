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

# Include any dependencies generated for this target.
include ee/CMakeFiles/voltdbjniobjs.dir/depend.make

# Include the progress variables for this target.
include ee/CMakeFiles/voltdbjniobjs.dir/progress.make

# Include the compile flags for this target's objects.
include ee/CMakeFiles/voltdbjniobjs.dir/flags.make

ee/CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.o: ee/CMakeFiles/voltdbjniobjs.dir/flags.make
ee/CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.o: ../src/ee/voltdbjni.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/russelhu/Github/voltdb/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object ee/CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.o"
	cd /Users/russelhu/Github/voltdb/cmake-build-debug/ee && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.o -c /Users/russelhu/Github/voltdb/src/ee/voltdbjni.cpp

ee/CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.i"
	cd /Users/russelhu/Github/voltdb/cmake-build-debug/ee && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/russelhu/Github/voltdb/src/ee/voltdbjni.cpp > CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.i

ee/CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.s"
	cd /Users/russelhu/Github/voltdb/cmake-build-debug/ee && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/russelhu/Github/voltdb/src/ee/voltdbjni.cpp -o CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.s

voltdbjniobjs: ee/CMakeFiles/voltdbjniobjs.dir/voltdbjni.cpp.o
voltdbjniobjs: ee/CMakeFiles/voltdbjniobjs.dir/build.make

.PHONY : voltdbjniobjs

# Rule to build all files generated by this target.
ee/CMakeFiles/voltdbjniobjs.dir/build: voltdbjniobjs

.PHONY : ee/CMakeFiles/voltdbjniobjs.dir/build

ee/CMakeFiles/voltdbjniobjs.dir/clean:
	cd /Users/russelhu/Github/voltdb/cmake-build-debug/ee && $(CMAKE_COMMAND) -P CMakeFiles/voltdbjniobjs.dir/cmake_clean.cmake
.PHONY : ee/CMakeFiles/voltdbjniobjs.dir/clean

ee/CMakeFiles/voltdbjniobjs.dir/depend:
	cd /Users/russelhu/Github/voltdb/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/russelhu/Github/voltdb /Users/russelhu/Github/voltdb/src/ee /Users/russelhu/Github/voltdb/cmake-build-debug /Users/russelhu/Github/voltdb/cmake-build-debug/ee /Users/russelhu/Github/voltdb/cmake-build-debug/ee/CMakeFiles/voltdbjniobjs.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : ee/CMakeFiles/voltdbjniobjs.dir/depend

