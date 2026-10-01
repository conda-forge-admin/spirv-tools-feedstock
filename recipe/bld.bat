mkdir build
if %ERRORLEVEL% neq 0 exit 1
cd build

cmake %CMAKE_ARGS% ^
  -GNinja ^
  -DSPIRV-Headers_SOURCE_DIR:PATH=%LIBRARY_PREFIX% ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
  -DSPIRV_TOOLS_LIBRARY_TYPE=SHARED ^
  -DSPIRV_TOOLS_BUILD_STATIC=OFF ^
  ..
if %ERRORLEVEL% neq 0 exit 1

ninja -j%CPU_COUNT%
if %ERRORLEVEL% neq 0 exit 1
ninja install
if %ERRORLEVEL% neq 0 exit 1

cmake -DSRC_DIR="%SRC_DIR%" -DBUILD_DIR="%CD%" ^
  -DDEST="%LIBRARY_INC%\spirv-tools-private" ^
  -P "%RECIPE_DIR%\install_private_headers.cmake"
if %ERRORLEVEL% neq 0 exit 1
