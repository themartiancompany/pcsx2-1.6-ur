# SPDX-License-Identifier: AGPL-3.0

#    ----------------------------------------------------------------------
#    Copyright © 2025  Pellegrino Prevete
#
#    All rights reserved
#    ----------------------------------------------------------------------
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Maintainer: Truocolo <truocolo@aol.com>
# Maintainer: Truocolo <truocolo@0x6E5163fC4BFc1511Dbe06bB605cc14a3e462332b>
# Maintainer: Pellegrino Prevete (dvorak) <pellegrinoprevete@gmail.com>
# Maintainer: Pellegrino Prevete (dvorak) <dvorak@0x87003Bd6C074C713783df04f36517451fF34CBEf>
# Maintainer: Maxime Gauduin <alucryd@archlinux.org>
# Contributor: josephgbr <rafael.f.f1@gmail.com>
# Contributor: vEX <vex@niechift.com>

_arch="$( \
  uname \
    -m)"
if [[ "${_arch}" == "i686" ]]; then
  _gcc="gcc"
elif [[ "${_arch}" == "x86_64" ]]; then
  _gcc="gcc-multilib"
fi
_pkg=pcsx2
_Pkg="PCSX2"
pkgname="${_pkg}-1.6"
pkgver=1.6.0
pkgrel=1
pkgdesc='A Sony PlayStation 2 emulator'
arch=(
  'i686'
  'x86_64'
  'arm'
  'armv7l'
  'aarch64'
  'armv6l'
  'powerpc'
  'pentium4'
)
url="http://www.${_pkg}.net"
license=(
  'GPL2'
  'GPL3'
  'LGPL2.1'
  'LGPL3'
)
_depends=(
  'glew'
  'libaio'
  'libcanberra'
  'libjpeg-turbo'
  'nvidia-cg-toolkit'
  'portaudio'
  'sdl2'
  'soundtouch'
  'wxgtk'
)
# My girsh it really requires multilib.
depends=()
for _depend in "${_depends[@]}"; do
  if [[ "${_arch}" == "x86_64" ]]; then
    _depend="lib32-${_depend}"
  fi
  depends+=(
    "${_depend}"
  )
done
makedepends=(
  'cmake'
  'png++'
  "${_gcc}"
)
_optdepends+=(
  'gtk-engines: GTK2 engines support'
  'gtk-engine-unico: Unico GTK2 engine support'
)
optdepends=()
for _optdepend in "${_optdepends[@]}"; do
  if [[ "" == "x86_64" ]]; then
    _optdepend="lib32-${_optdepend}"
  fi
  optdepends+=(
    "${_optdepend}"
  )
done
options=(
  '!emptydirs'
)
_http="https://github.com"
_ns="${_Pkg}"
_url="${_http}/${_ns}/${_pkg}"
source=(
  "${_pkg}-${pkgver}.tar.gz::${_url}/archive/v${pkgver}.tar.gz"
)
sha256sums=(
  'c09914020e494640f187f46d017f9d142ce2004af763b9a6c5c3a9ea09e5281c'
)

prepare() {
  cd \
    "${_pkg}-${pkgver}"
  # Fix build with GCC 6
  # patch \
  #   -p1 \
  #   -i \
  #   "../pcsx2-gcc6.patch"
}

_usr_get() {
  local \
    _bin
  _bin="$( \
    dirname \
      "$(command \
           -v \
	   "env")")"
  dirname \
    "${_bin}"
}

build() {
  local \
    _cmake_opts=() \
    _plugin_dir \
    _cmake_library_path
  _cmake_opts+=(
    -DCMAKE_BUILD_TYPE='Release'
    -DCMAKE_INSTALL_PREFIX='/usr'
    -DGAMEINDEX_DIR="/usr/share/${_pkg}"
    -DDISABLE_ADVANCE_SIMD='TRUE'
    -DEXTRA_PLUGINS='TRUE'
    -DREBUILD_SHADER='TRUE'
    -DGLSL_API='TRUE'
    -DPACKAGE_MODE='TRUE'
    -DXDG_STD='TRUE'
  )
  _plugin_dir="/usr/lib/${_pkg}"
  _cmake_library_path="/usr/lib"
  if [[ "${_arch}" == "x86_64" ]]; then
    # I dont know if it really needs
    # multilib, lets test without for
    # now.
    _cmake_opts+=(
      -DCMAKE_TOOLCHAIN_FILE="cmake/linux-compiler-i386-multilib.cmake"
      # This should be fixed in 
      # https://github.com/PCSX2/pcsx2/issues/1933
      # -DwxWidgets_CONFIG_EXECUTABLE="/usr/bin/wx-config32"
    )
    _cmake_library_path+="32"
    _plugin_dir="/usr/lib32/${_pkg}"
  fi
  _cmake_opts+=(
    -DCMAKE_LIBRARY_PATH="${_cmake_library_path}"
    -DPLUGIN_DIR="${_plugin_dir}"
  )
  cd \
    "${_pkg}-${pkgver}"
  if [[ -d build ]]; then
    rm \
      -rf \
      "build"
  fi
  mkdir \
    "build"
  cd \
    "build"
  cmake .. \
    "${_cmake_opts[@]}"
  make
}

package() {
  cd \
    "${_pkg}-${pkgver}/build"
  make \
    DESTDIR="${pkgdir}" \
    install
}

# vim: ts=2 sw=2 et:
