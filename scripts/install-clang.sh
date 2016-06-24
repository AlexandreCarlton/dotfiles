#!/bin/sh

# Set these to the relevant fields.
PYTHON=
CC=
CXX=

version='3.8.0'

. libs-install-from-source.sh


llvm_url="http://llvm.org/releases/${version}/llvm-${version}.src.tar.xz"
clang_url="http://llvm.org/releases/${version}/cfe-${version}.src.tar.xz"
extra_url="http://llvm.org/releases/${version}/clang-tools-extra-${version}.src.tar.xz"

llvm_folder="$(get_folder_from_url "${llvm_url}")"

cd "${BASE_FOLDER}"
extract_tar_folder_from_url "${llvm_url}"
extract_tar_folder_from_url "${clang_url}" "${llvm_folder}/tools/clang"
extract_tar_folder_from_url "${extra_url}" "${llvm_folder}/tools/clang/tools/extra"

make_folder "${llvm_folder}" -DPYTHON_EXECUTABLE=${PYTHON}
stow_folder "${llvm_folder}"
