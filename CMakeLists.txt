# Copyright (C) 2011 LuaDist
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

# This is a straightforward bootstrap for LuaDist.
project ( luadist_installer NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( ExternalProject )

## SETTINGS
# Build Release by default
if ( NOT CMAKE_BUILD_TYPE)
  set ( CMAKE_BUILD_TYPE "MinSizeRel" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE )
endif ()

# Bootstrap destination
set ( BOOT_PREFIX ${CMAKE_INSTALL_PREFIX}/tmp/bootstrap )

# Install dists required for bootstrap by default
set ( DISTS lua luafilesystem luasocket luadist )

# Generate cache
configure_file ( config.in ${CMAKE_CURRENT_BINARY_DIR}/config.cmake )

## External projects needed for Bootstrap
macro ( install_dist _DIST )
  # Build project with all configuration
  ExternalProject_Add( ${_DIST} 
      PREFIX ${_DIST}
      BINARY_DIR ${_DIST}/build
      INSTALL_DIR ${BOOT_PREFIX}
      SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${_DIST}
      CMAKE_ARGS -C ${CMAKE_CURRENT_BINARY_DIR}/config.cmake
      DEPENDS ${_PREV}
    )
    set ( _PREV ${_DIST})
endmacro ()

# Build all dists
foreach ( DIST ${DISTS} )
  install_dist ( ${DIST} )
endforeach ()

# On CMake 2.8.2 (Ubuntu) This may generate an error even if everything is fine. Ignore it, or update to 2.8.4.
add_custom_target ( install
  COMMAND ${BOOT_PREFIX}/bin/luadist ${CMAKE_INSTALL_PREFIX} install luadist -repo=${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS ${_PREV}
)
