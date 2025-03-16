#!/usr/bin/env bash

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

_launch() {
  local \
    _pcsx2_opts=() \
    _wx
  _pcsx2_opts=(
    "$@"
  )
  _wx="/usr/lib32/wxwidgets3.0"
  env \
    GDK_BACKEND="x11" \
    LD_LIBRARY_PATH="${_wx}" \
    __GL_THREADED_OPTIMIZATIONS=1 \
    mesa_glthread="true" \
    MESA_NO_ERROR=1 \
    "PCSX2-1.6" \
      "${_pcsx2_opts[@]}"
}

_opts=(
  "$@"
)

_launch \
  "${_opts[@]}"
