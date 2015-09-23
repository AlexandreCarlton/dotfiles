#!/bin/sh

VERSION=2.2.3
BUILD_DIR="/tmp/build_ruby"

INSTALL_DIR="${HOME}/.local"
LD_LIBRARY_PATH="${INSTALL_DIR}/lib:${LD_LIBRARY_PATH}"
FOLDER="ruby-${VERSION}"
FILE="${FOLDER}.tar.gz"
URL="https://cache.ruby-lang.org/pub/ruby/2.2/${FILE}"

mkdir -p "${BUILD_DIR}"
mkdir -p "${INSTALL_DIR}"

cd "${BUILD_DIR}"
curl -OLv "${URL}"

# From
tar xzf "${FILE}"
cd "${FOLDER}"
./configure --prefix="${INSTALL_DIR}"
make -j
make install
