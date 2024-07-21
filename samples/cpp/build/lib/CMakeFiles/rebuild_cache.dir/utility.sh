set -e

cd /c/Users/Maurice/AppData/Local/nvim/samples/cpp/build/lib
/usr/bin/cmake.exe --regenerate-during-build -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
