#!/bin/sh

install_i3gaps() {
  rm -rfv /tmp/i3-gaps
  cd /tmp

  # clone the repository
  git clone https://www.github.com/Airblader/i3 i3-gaps
  cd i3-gaps

  # compile & install
  autoreconf --force --install
  rm -rf build/
  mkdir -p build && cd build/

  # Disabling sanitizers is important for release versions!
  # The prefix and sysconfdir are, obviously, dependent on the distribution.
  ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
  make
  sudo make install
}

install_polybar() {
  rm -rfv /tmp/polybar
  cd /tmp

  # Make sure to type the `git' command as is to clone all git submodules too
  git clone --recursive https://github.com/jaagr/polybar
  mkdir polybar/build
  cd polybar/build
  cmake ..
  sudo make install
}

# Dependencias para i3-gaps
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

# Dependencias para polybar
sudo apt install -y build-essential git cmake cmake-data pkg-config libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev

# Ferramentas extras
sudo apt install -y git vim dmenu i3status lxappearance variety feh compton i3lock-fancy stow

# Verifica se i3-gaps estah instalado
i3 --version

# Se nao estiver, instala
if [ $? -ne 0 ]; then 
  install_i3gaps
fi

install_polybar
