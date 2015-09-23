#!/bin/sh

VERSION=5.2.0
BUILD_DIR="/tmp/build_gcc"

INSTALL_DIR="${HOME}/.local"
LD_LIBRARY_PATH="${INSTALL_DIR}/lib:${LD_LIBRARY_PATH}"
FOLDER="gcc-${VERSION}"
FILE="${FOLDER}.tar.gz"
URL="https://ftp.gnu.org/gnu/gcc/${FOLDER}/${FILE}"

mkdir -p "${BUILD_DIR}"
mkdir -p "${INSTALL_DIR}"

cd "${BUILD_DIR}"
curl -OLv "${URL}"

# From gcc.gnu.org/wiki/InstallingGCC
tar xzf "${FILE}"
cd "${FOLDER}"
./contrib/download_prerequisites
cd ..
mkdir object_dir
cd object_dir
"${PWD}/../${FOLDER}/configure" --prefix="${INSTALL_DIR}" \
                                --enable-languages=c,c++
make -j
make install
