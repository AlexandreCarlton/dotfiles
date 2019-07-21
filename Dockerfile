FROM alexandrecarlton/systemd:latest

RUN pacman --sync --refresh --refresh --upgrade && \
    pacman --sync --noconfirm \
      make \
      vim \
      stow

ARG user
RUN useradd --create-home "${user}"

USER "${user}"
