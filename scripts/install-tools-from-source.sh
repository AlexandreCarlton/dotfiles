#!/bin/sh

# Locally installs several useful utilities from source
# Useful for when we're on a reaaaally old server (and Linuxbrew won't save you)
# Like, who even uses RHEL5 anymore?


# Modify as necessary
BASE_FOLDER="${HOME}/Source"
PREFIX="${HOME}/.local"
PYTHON="$(which python)" # Needed for cmake
# CC=
# CXX=

# Man I really wish you could fall-through in POSIX.
get_url() {
  local binary="${1}"
  local version="${2}"
  local url
  case "${binary}" in
    'coreutils')
      url="$(gnu_url 'coreutils')"
      ;;
    'fish')
      url="https://fishshell.com/files/${version}/fish-${version}.tar.gz"
      ;;
    'libevent')
      url="https://github.com/libevent/libevent/releases/download/release-${version}-stable/libevent-${version}-stable.tar.gz"
      ;;
    'pcre')
      url="http://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${version}.tar.gz"
      ;;
    'stow')
      url="$(gnu_url 'stow' "${version}")"
      ;;
    'tar')
      url="$(gnu_url 'tar' "${version}")"
      ;;
    'the_silver_searcher')
      url="http://geoff.greer.fm/ag/releases/the_silver_searcher-${version}.tar.gz"
      ;;
    'tmux')
      url="https://github.com/tmux/tmux/releases/download/${version}/tmux-${version}.tar.gz"
      ;;
    'vim')
      url="https://github.com/vim/vim/archive/v${version}.tar.gz"
      ;;
    'xz')
      url="http://tukaani.org/xz/xz-${version}.tar.gz"
      ;;
    'zsh')
      url="http://sourceforge.net/projects/zsh/files/zsh/${version}/zsh-${version}.tar.gz/download"
      ;;
  esac
  printf '%s' "${url}"
}

gnu_url() {
  local binary="${1}"
  local version="${2}"
  printf "http://ftp.gnu.org/gnu/%s/%s-%s.tar.gz" \
    "${binary}" "${binary}" "${version}"
}

get_folder_from_url() {
  local url="${1}"
  # TODO: Make more flexible if necessary; see commit log for this line.
  local pattern='.*/([a-z]+-[0-9.]+[a-z\-]*)\.tar\..*'
  local folder='\1'
  printf '%s' "${url}" |\
    sed --regexp-extended --quiet "s|${pattern}|${folder}|p"
}

get_tar_extenion_from_url() {
  local url="${1}"
  printf '%s' "${url}" |\
    sed --regexp-extended --quiet 's;.*\.tar\.((gz|bz2|xz)).*;\1;p'
}

get_tar_filter_from_url() {
  local url="${1}"
  local extension
  extension="$(get_tar_extenion_from_url "${url}")"

  local filter=''
  case "${extension}" in
    'gz')
      filter='gzip'
      ;;
    'xz')
      filter='xz'
      ;;
    'bz2')
      filter='bzip2'
      ;;
  esac
  printf '%s' "${filter}"
}

# TODO Rename to extract_tar_from_url
# And make extract_tar_from_url_to_folder - has the -C --strip-components (useful for clang)
create_build_folder() {
  local url="${1}"
  printf 'Downloading and extracting %s...\n' "${url}"
  cd "${BASE_FOLDER}" || exit
  local filter="$(get_tar_filter_from_url "${url}")"
  # TODO: Assumes we got non-empty string; account for this.
  curl --silent --location "${url}" |\
    tar --extract "--${filter}"
}

extract_tar_from_url_to_folder() {
  local url="${1}"
  local folder="${2}"
  # TODO: Should we change to base folder?
  cd "${BASE_FOLDER}" || exit
  local filter="$(get_tar_filter_from_url "${url}")"

  mkdir -p "${folder}"
  curl --silent --location "${url}" |\
    tar --extract "--${filter}" \
        --directory="${folder}" --strip-components=1
}

make_folder() {
  local folder="${1}"
  local options="${@:2}"

  cd "${folder}" || exit
  ./configure --prefix="${PREFIX}" "${options}"
  make --jobs
  make install prefix="${PREFIX}/stow/${folder}"
}

stow_folder() {
  local folder="${1}"
  if [ "${folder:0:4}" = 'stow' ]: then
    "${PREFIX}/stow/${folder}/bin/stow" --dir="${PREFIX}/stow" "${folder}"
  else
    stow --dir="${PREFIX}/stow" "${folder}"
  fi
}

install_from_url() {
  local url="${1}"
  local configure_options="${@:2}"

  local folder="$(get_folder_from_url "${url}")"
  if [ -z "${folder}" ]; then
    printf 'Could not extract folder name from url "%s".\n' "${url}"
    return
  elif [ ! -d "${folder}" ]; then
    create_build_folder "${url}"
  else
    printf 'Folder %s already present, skipping download and extraction...\n' "${folder}"
  fi

  make_folder "${folder}" "${configure_options}"
  stow_folder "${folder}"
}

install_binary() {
  local binary="${1}"
  local version="${2}"
  local configure_options="${@:3}"

  local url
  url="$(get_url "${binary}" "${version}")"
  if [ -n "${url}" ]; then
    install_from_url "${url}" "${configure_options}"
  else
    printf 'No configuration for %s configured; skipping.\n' "${binary}"
  fi
}

# Installing clang is a bit complex and thus warrants its own function.
# If possible we'll refactor this later.
# To extract in one line:
# mkdir <folder> && tar <blah>.tar.gz -C <folder> --strip-components=1
# - -C changes to a specified folder, and strip-components=1 strips away the first part of the thing.

install_clang() {
  local version="${1}"

  local llvm_url="http://llvm.org/releases/${version}/llvm-${version}.src.tar.xz"
  local llvm_folder="$(get_folder_from_url "${llvm_url}")"
  local clang_url="http://llvm.org/releases/${version}/cfe-${version}.src.tar.xz"
  local clang_folder="$(get_folder_from_url "${clang_url}")"
  local extra_url="http://llvm.org/releases/${version}/clang-tools-extra-${version}.src.tar.xz"
  local extra_folder="$(get_folder_from_url "${extra_url}")"

  cd "${BASE_FOLDER}"
  extract_tar_from_url_to_folder "${llvm_url}" llvm
  extract_tar_from_url_to_folder "${clang_url}" llvm/tools/clang
  extract_tar_from_url_to_folder "${extra_url}" llvm/tools/clang/tools/extra

  # TODO: make a cmake_folder function which does something similar to make_folder
  mkdir -p llvm/build
  cd llvm/build
  cmake .. -DPYTHON_EXECUTABLE=${PYTHON} -DCMAKE_INSTALL_PREFIX="${PREFIX}"
  #make -j
  #make install
}


# mkdir -p "${BASE_FOLDER}"
# install_binary 'stow' '2.2.2'
# install_binary 'xz' '5.2.2'
# install_binary 'tar' '1.29'
# install_binary 'libevent' '2.0.22'
# install_binary 'tmux' '2.2'
# install_binary 'vim' '7.4.1916' \
#   --with-features=huge \
#   --enable-multibyte \
#   --enable-rubyinterp \
#   --enable-pythoninterp \
#   --with-python-config-dir="${HOME}/.local/lib/python2.7/config" \
#   --enable-luainterp \
#   --enable-cscope \
#   --disable-gui \
#   --without-x
#   # --enable-perlinterp # Perl support is weird.
# install_binary 'zsh' '5.2'

# install_binary 'pcre' '8.39' \
#   --enable-unicode-properties \
#   --enable-pcre16 \
#   --enable-pcre32 \
#   --enable-pcregrep-libz \
#   --enable-pcregrep-libbz2
# install_binary 'the_silver_searcher' '0.32.0'

# install_binary 'xz' '5.2.2'
# install_clang '3.8.0'

