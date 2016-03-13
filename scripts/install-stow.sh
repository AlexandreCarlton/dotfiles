#!/bin/sh

VERSION='2.2.2'
BUILD_DIR='/tmp/build_stow'

INSTALL_DIR="${HOME}/.local"
FOLDER="stow-${VERSION}"
FILE="${FOLDER}.tar.gz"
URL="https://ftp.gnu.org/gnu/stow/${FILE}"

mkdir -p "${BUILD_DIR}"
mkdir -p "${INSTALL_DIR}"

cd "${BUILD_DIR}"
wget "${URL}"

tar xzf "${FILE}"
cd "${FOLDER}"

./configure --prefix="${INSTALL_DIR}"
make -j
make install
