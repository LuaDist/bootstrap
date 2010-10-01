# Copyright (C) 2007-2010 LuaDist.
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

# This is a convinience build script to bootstrap all needed dependencies for LuaDist which 
# then builds itself. Actual LuaDist source is in dists/Lua/Utilities/luadist.
PROJECT ( luadistall C )
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
SET (DIST_VERSION 1.0.0)

SET (LUA_SRC_DIR dists/Lua/Interpreters/lua/src)
SET (LFS_SRC_DIR dists/Lua/Modules/luafilesystem/src)
SET (DIST_SRC_DIR dists/Lua/Utilities/luadist)

# Architecture and type.
# LuaDist uses arch-type designation for binary modules. Arch can be generic:
# Linux, Windows, Darwin, etc. Type is mostly the processor type or compiler
# type.  By default cmake sets these to its internal variables but its
# recommended you recheck before compiling.
# Do architecture specific tweaks.
SET (DETECTED_TYPE ${CMAKE_SYSTEM_PROCESSOR})
SET (DETECTED_ARCH ${CMAKE_SYSTEM_NAME})

IF (CYGWIN)
	# Make sure Cygwin uses correct arch and type.
	SET(DETECTED_TYPE x86)
	SET(DETECTED_ARCH Cygwin)
ELSEIF (MSVC)
	# Change the type apropritely to avoid binary problems with MinGW.
	SET(DETECTED_TYPE MSVC32)
ENDIF ()

SET (DIST_TYPE ${DETECTED_TYPE} CACHE STRING "Host system type. PLEASE CHECK!" FORCE)
SET (DIST_ARCH ${DETECTED_ARCH} CACHE STRING "Host system architecture. PLEASE CHECK!" FORCE)

# Build bootstrapping Lua interpretter.
# This is a statically linked Lua with essential libraries built-in.
FILE(READ ${LUA_SRC_DIR}/linit.c LUA_LINIT_STR)
STRING(REGEX REPLACE "(static.*)(  {NULL, NULL})"
                     "#include \"lfs.h\"\n\\1  {\"lfs\", luaopen_lfs},\n\\2"
                     LUA_LINIT_STR "${LUA_LINIT_STR}")
FILE(WRITE ${CMAKE_CURRENT_BINARY_DIR}/linit.c "${LUA_LINIT_STR}")
IF (MSVC)
	ADD_DEFINITIONS( -D_CRT_SECURE_NO_DEPRECATE )
ELSEIF ( WIN32 AND NOT CYGWIN )
ELSE ()
	SET ( LIBS m )
ENDIF ()
SET (SRC_LIBLUA
  ${LUA_SRC_DIR}/lapi.c
  ${LUA_SRC_DIR}/lcode.c
  ${LUA_SRC_DIR}/ldebug.c
  ${LUA_SRC_DIR}/ldo.c
  ${LUA_SRC_DIR}/ldump.c
  ${LUA_SRC_DIR}/lfunc.c
  ${LUA_SRC_DIR}/lgc.c
  ${LUA_SRC_DIR}/llex.c
  ${LUA_SRC_DIR}/lmem.c
  ${LUA_SRC_DIR}/lobject.c
  ${LUA_SRC_DIR}/lopcodes.c
  ${LUA_SRC_DIR}/lparser.c
  ${LUA_SRC_DIR}/lstate.c
  ${LUA_SRC_DIR}/lstring.c
  ${LUA_SRC_DIR}/ltable.c
  ${LUA_SRC_DIR}/ltm.c
  ${LUA_SRC_DIR}/lundump.c
  ${LUA_SRC_DIR}/lvm.c
  ${LUA_SRC_DIR}/lzio.c
  ${LUA_SRC_DIR}/lauxlib.c
  ${LUA_SRC_DIR}/lbaselib.c
  ${LUA_SRC_DIR}/ldblib.c
  ${LUA_SRC_DIR}/liolib.c
  ${LUA_SRC_DIR}/lmathlib.c
  ${LUA_SRC_DIR}/loslib.c
  ${LUA_SRC_DIR}/ltablib.c
  ${LUA_SRC_DIR}/lstrlib.c
  ${LUA_SRC_DIR}/loadlib.c
  ${CMAKE_CURRENT_BINARY_DIR}/linit.c   # note: patched version
)
SET (SRC_LUA ${LUA_SRC_DIR}/lua.c)
SET (SRC_LFS ${LFS_SRC_DIR}/lfs.c)
INCLUDE_DIRECTORIES ( ${LUA_SRC_DIR} )
INCLUDE_DIRECTORIES ( ${LFS_SRC_DIR} )
ADD_EXECUTABLE ( lua-bootstrap ${SRC_LUA} ${SRC_LIBLUA} ${SRC_LFS} )
TARGET_LINK_LIBRARIES ( lua-bootstrap ${LIBS})

# Install
SET (DIST_BOOTSTRAP true)
ADD_SUBDIRECTORY (${DIST_SRC_DIR})

ADD_CUSTOM_TARGET(
	install
	COMMAND	"${CMAKE_COMMAND}"
			"-D" "DIST_ROOT=${CMAKE_BINARY_DIR}"
			"-D" "DIST_SRC=${DIST_SRC_DIR}"
			"-D" "SOURCE=${CMAKE_SOURCE_DIR}"
			"-D" "INSTALL_DIR=${CMAKE_SOURCE_DIR}/_install/luadist-${DIST_VERSION}-${DIST_ARCH}-${DIST_TYPE}"
			"-P" "${CMAKE_SOURCE_DIR}/Install.cmake"
	DEPENDS lua-bootstrap
)
