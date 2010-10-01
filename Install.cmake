# Install script to set environment and run LuaDist 
SET(ENV{DIST_ROOT} "${DIST_ROOT}")
SET(ENV{LUA_PATH} "${DIST_ROOT}/${DIST_SRC}/?.lua;${SOURCE}/${DIST_SRC}/lmod/?.lua")

EXECUTE_PROCESS(
  COMMAND "${DIST_ROOT}/lua-bootstrap"
          "${SOURCE}/${DIST_SRC}/luadist"
          "${INSTALL_DIR}"
          "install" "luadist-tools"
		  "-verbose=true"
          "-repo=file://${SOURCE}/dists"
)
