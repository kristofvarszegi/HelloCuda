

: ${DEPS_DIR=.}
export MAKEFLAGS=-j6
cmake -H. -B../HelloCuda-build \
    -DCMAKE_CXX_STANDARD=11 \
    -G"Eclipse CDT4 - Unix Makefiles" \
    -DCMAKE_INSTALL_PREFIX=${DEPS_DIR} \
    -DCMAKE_PREFIX_PATH="${DEPS_DIR}" \
    -DCMAKE_BUILD_TYPE=Debug
cmake --build ../HelloCuda-build --target install