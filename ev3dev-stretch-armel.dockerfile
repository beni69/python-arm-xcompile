FROM ev3dev/debian-stretch-cross

RUN sudo apt update && sudo apt upgrade --yes && \
  DEBIAN_FRONTEND=noninteractive sudo apt install --yes --no-install-recommends \
  build-essential \
  git \
  libncurses-dev:armel \
  libgdbm-dev:armel \
  libz-dev:armel \
  tk-dev:armel \
  libsqlite3-dev:armel \
  liblzma-dev:armel \
  libffi-dev:armel \
  libssl-dev:armel

