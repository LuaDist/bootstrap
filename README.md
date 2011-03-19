Bootstrap and Installation repository for the LuaDist project
===

This repository contains an installation script that allows automated building of LuaDist modules. There are two modes of operation available. First mode is for bootstrapping the _luadist_ deployment utility that offers complete package management functionality and automated dependency resolving. However this requires compilation of _openssl_ and other utilities you may not want.

The second mode of operation directly checks out repositories using git and installs the modules without dependency handling. Using this approach you can tailor your distribution from ground up without unneeded dependencies.

Bootstraping LuaDist deployment tool
---

To build LuaDist with everything under version management the build process requires two steps.

Step one. Build bootstrap luadist (WARNING: This is only used to build the final result.)

    git clone git://github.com/LuaDist/Bootstrap.git
    cd Bootstrap
    git submodule init
    git submodule update
    ./install lua luafilesystem luadist

Step two. Build final LuaDist using the bootstrap.

    ./bin/luadist _install install luadist -repo=$PWD/dists
    
Once the installation finishes the _install folder should contain a fully versioned LuaDist distribution.

    cd _install
    ./bin/luadist list # lists installed modules
    ./bin/luadist search # lists online repository
    ./bin/luadist install luaexpat # installs luaexpat     

Using the install script to generate distribution without versioning.
---

To make a distribution containing luajit, luasocket and luafilesystem you just need to do the following:

    git clone git://github.com/LuaDist/Bootstrap.git
    cd Bootstrap
    ./install luajit luasocket luafilesystem
    
Note that this mode of installation installs most recent versions of modules and does not handle dependencies automatically. However, the installation script is able to install specific tags of modules. It is up to you to install correct dependencies, otherwise the distribution may be unusable.

    ./install md5-1.1.2 
    ./bin/lua
    > require "md5"
    
Adding new modules can be done anytime later with the installation script. Once your installation is finalized you can safely remove all files and directories other than bin, lib, include, etc and share.
