#!/bin/sh

# It would be nice if we could detect if the script was being sourced or executed.

# Provides functions to locally install utilities from source
# Useful for when we're on a reaaaally old server
# (when even Linuxbrew won't save you)
# Like, who even uses RHEL5 anymore?


# Modify as necessary
BASE_FOLDER="${HOME}/Source"
PREFIX="${HOME}/.local"


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

extract_tar_folder_from_url() {
  local url="${1}"
  local folder="${2}" # Optional
  if [ -n "${folder}" ]; then
    mkdir -p "${folder}"
    local extra_options="--directory=${folder} --strip-components=1"
  else
    local extra_options=""
    printf 'No folder name provided for %s, using default...\n' "${url}"
  fi

  mkdir -p "${BASE_FOLDER}"
  cd "${BASE_FOLDER}"

  # TODO: We currently assume a non-empty filter.
  local filter
  filter="$(get_tar_filter_from_url "${url}")"

  printf 'Downloading and extracting %s...\n' "${url}"
  curl --silent --location "${url}" |\
    tar --extract "--${filter}" \
        "${extra_options}"
}

make_folder() {
  local folder="${1}"
  local options="${@:2}"

  cd "${folder}" || exit
  if [ -e 'CMakeLists.txt' ]; then
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX="${PREFIX}" "${options}"
  else
    ./configure --prefix="${PREFIX}" "${options}"
  fi

  make --jobs
  # TODO: Check if we should be using DESTDIR instead.
  make install prefix="${PREFIX}/stow/${folder}"
}

stow_folder() {
  local folder="${1}"
  if [ "${folder:0:4}" = 'stow' ]; then
    "${PREFIX}/stow/${folder}/bin/stow" --dir="${PREFIX}/stow" "${folder}"
  else
    stow --dir="${PREFIX}/stow" "${folder}"
  fi
}

install_from_url() {
  local url="${1}"
  local configure_options="${@:2}"

  local folder
  folder="$(get_folder_from_url "${url}")"

  if [ -z "${folder}" ]; then
    printf 'Could not extract folder name from url "%s".\n' "${url}"
    return
  elif [ ! -d "${folder}" ]; then
    extract_tar_folder_from_url "${url}"
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
