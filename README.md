Welcome to the LuaDist project.
===

About LuaDist
---
LuaDist is a [CMake](http://www.cmake.org)-based multi-platform standalone [Lua](http://www.lua.org) distribution providing a build environment and module management. For more information please visit [www.luadist.org](http://www.luadist.org).

Availability
---
LuaDist is freely available for both academic and commercial purposes under MIT license. See COPYRIGHT for details. Please see individual packages for their license.

Goals
---
LuaDist follows two separate goals.

- Manage a repository of CMake scripts for building Lua related software
- Provide automated deployment utility for our modules.

This means that our modules and build scripts can be used by separate projects or users who want to install their software manually using CMake. All produced modules are available for download at [dists.luadist.org](http://dists.luadist.org). For convenience and users not familiar with CMake we provide the _luadist_ deployment utility which can install modules from source or use binary packages.

Structure of this repository
---
The root contains CMake build scripts used to bootstrap initial installationof LuaDist deployment utility. Building requires CMake 2.8 and is initiated by running the appropriate build script. Result is stored in _install directory that the process will create.

The _dists_ directory contains prototypes of all our maintained modules ordered into subdirectories. Sources of the modules are usually not stored in the repository and need to be downloaded and extracted. For this purpose there is a simple _luadist-assemble_ tool available that will automatically download and patch the sources. Zipping the resulting directory produces a _dist_ package suitable for redistribution using the _luadist_ tool.
