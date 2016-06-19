#!/bin/sh

# Locally installs several useful utilities from source
# Useful for when we're on a reaaaally old server.
# Like, who even uses RHEL5 anymore?

BASE_FOLDER="${HOME}/extracted_tarballs"
PREFIX="${HOME}/.local"

# Man I really wish you could fall-through in POSIX.
get_url() {
  local binary="${1}"
  local version="${2}"
  local url
  case "${binary}" in
    'fish')
      url="https://fishshell.com/files/${version}/fish-${version}.tar.gz"
      ;;
    'libevent')
      url="https://github.com/libevent/libevent/releases/download/release-${version}-stable/libevent-${version}-stable.tar.gz"
      ;;
    'stow')
      url="$(gnu_url 'stow' "${version}")"
      ;;
    'tmux')
      url="https://github.com/tmux/tmux/releases/download/${version}/tmux-${version}.tar.gz"
      ;;
    'vim')
      url="https://github.com/vim/vim/archive/v${version}.tar.gz"
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
  local pattern='.*/([a-z]+-[0-9.]+[a-z\-]*)\.tar\.gz.*'
  local folder='\1'
  printf '%s' "${url}" |\
    sed --regexp-extended --quiet "s|${pattern}|${folder}|p"
}

create_build_folder() {
  local url="${1}"
  printf 'Downloading and extracting %s...\n' "${url}"
  cd "${BASE_FOLDER}" || exit

  curl --silent --location "${url}" |\
    tar --extract --gzip
}

make_folder() {
  local folder="${1}"
  local options="${@:2}"

  cd "${folder}" || exit
  ./configure --prefix="${PREFIX}" "${options}"
  make --jobs
  make install
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


# mkdir -p "${BASE_FOLDER}"
# install_binary 'stow' '2.2.2'
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
