# Copyright (C) 2013 LuaDist
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

# This is a straightforward bootstrap for LuaDist.
project ( luadist_bootstrap NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( ExternalProject )

## SETTINGS
# Build Release by default
if ( NOT CMAKE_BUILD_TYPE)
  set ( CMAKE_BUILD_TYPE "MinSizeRel" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE )
endif ()

# Bootstrap destination
set ( BOOT_PREFIX ${CMAKE_INSTALL_PREFIX} )

# Install dists required for bootstrap by default
set ( DISTS 
  lua
  srlua
  luafilesystem
  luasocket
  zlib
  lua-git
  luadist-git
)

# Generate cache file with configuration from config.in
configure_file ( config.in ${CMAKE_CURRENT_BINARY_DIR}/config.cmake )

macro ( install_dist _DIST )
  set ( _DIST_SOURCE GIT_REPOSITORY http://github.com/LuaDist/${_DIST}.git GIT_TAG master )

  # Build project using the generated settings in cache
  ExternalProject_Add( ${_DIST}
      PREFIX ${_DIST}
      ${_DIST_SOURCE}
      BINARY_DIR ${_DIST}
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CMAKE_ARGS -C ${CMAKE_CURRENT_BINARY_DIR}/config.cmake
      DEPENDS ${_PREV}
    )
    set ( _PREV ${_DIST})
    list ( APPEND DEPS ${_DIST} )
endmacro ()

# Build all modules one after another
foreach ( DIST ${DISTS} )
  install_dist ( ${DIST} )
endforeach ()

# Make a fake target
add_custom_target ( install
  COMMAND echo "Bootstrap finished: ${BOOT_PREFIX}."
  DEPENDS ${_PREV}
)
