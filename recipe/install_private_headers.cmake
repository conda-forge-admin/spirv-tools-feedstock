# Install the private (internal) headers of SPIRV-Tools for consumers such as
# Tint (Dawn's shader compiler) that use the spvtools::opt C++ API directly.
# Headers include each other as "source/..." and include generated headers by
# bare name, so both live under a single include root. The internal API is not
# stable.
#
# Usage: cmake -DSRC_DIR=<source> -DBUILD_DIR=<build> -DDEST=<dir> -P install_private_headers.cmake
file(GLOB_RECURSE headers RELATIVE "${SRC_DIR}" "${SRC_DIR}/source/*.h")
foreach(header IN LISTS headers)
  get_filename_component(header_dir "${header}" DIRECTORY)
  file(COPY "${SRC_DIR}/${header}" DESTINATION "${DEST}/${header_dir}")
endforeach()
file(COPY
  "${BUILD_DIR}/DebugInfo.h"
  "${BUILD_DIR}/OpenCLDebugInfo100.h"
  "${BUILD_DIR}/core_tables_header.inc"
  DESTINATION "${DEST}")
