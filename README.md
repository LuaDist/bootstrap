LuaDist Bootstrap
=================
This repository contains an installation script that will bootstrap a self contained LuaDist distribution. To build LuaDist please make sure your system has git, CMake 2.8 and a compiler tool-chain available. On Ubuntu this requires git, cmake, build-essential. This build will take quite a while to compile, please be patient.

    git clone git://github.com/LuaDist/bootstrap.git
    cd bootstrap
    ./bootstrap
   
Once the installation finishes the LuaDist folder should contain a fully versioned LuaDist distribution.

    cd _install
    ./bin/luadist list # lists installed modules
    ./bin/luadist search # lists online repository
    ./bin/luadist install luaexpat # installs luaexpat     
	
Contributing
------------

1. Submit a [issue][issue] with a link to your git repository of the module.
2. A maintainer will fork the module into LuaDist grant you the rights to push changes into it.
3. The maintainer will add a submodule referencing the forked module into this LuaDist/Repository.

Call for Maintainers
--------------------

If you would like to help us maintain the repository and update modules without maintainers you are more than welcome. Please contact us at our [development list][mail]

[mail]: mailto:luadist-devel@lists.sourceforge.net
