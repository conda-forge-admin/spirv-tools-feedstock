set -ex
mkdir build
cd build

if [[ "${target_platform}" == osx-64 ]]; then
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DSPIRV_TOOLS_LIBRARY_TYPE=SHARED \
  -DSPIRV_TOOLS_BUILD_STATIC=OFF \
  -DSPIRV-Headers_SOURCE_DIR="${PREFIX}" \
  ..

make -j${CPU_COUNT}
make install

cmake -DSRC_DIR="${SRC_DIR}" -DBUILD_DIR="${PWD}" \
  -DDEST="${PREFIX}/include/spirv-tools-private" \
  -P "${RECIPE_DIR}/install_private_headers.cmake"
