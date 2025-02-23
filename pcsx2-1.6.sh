#!/usr/bin/env bash

_launch() {
  local \
    _libs=() \
    _wx_libs=() \
    _wx_gtk2_libs=() \
    _wx_gtk3_libs=() \
    _wx
  _wx="/usr/lib32/wxwidgets3.0"
  _wx_libs=(
    "${_wx}/libwx_baseu_net-3.0.so.0"
    "${_wx}/libwx_baseu-3.0.so.0"
    "${_wx}/libwx_baseu_xml-3.0.so.0"
  )
  _wx_gtk2_libs=(
    "${_wx}/libwx_gtk2u_aui-3.0.so.0"
    "${_wx}/libwx_gtk2u_qa-3.0.so.0"
    "${_wx}/libwx_gtk2u_propgrid-3.0.so.0"
    "${_wx}/libwx_gtk2u_xrc-3.0.so.0"
    "${_wx}/libwx_gtk2u_core-3.0.so.0"
    "${_wx}/libwx_gtk2u_richtext-3.0.so.0"
    "${_wx}/libwx_gtk2u_adv-3.0.so.0"
    "${_wx}/libwx_gtk2u_media-3.0.so.0"
    "${_wx}/libwx_gtk2u_ribbon-3.0.so.0"
    "${_wx}/libwx_gtk2u_gl-3.0.so.0"
    "${_wx}/libwx_gtk2u_stc-3.0.so.0"
    "${_wx}/libwx_gtk2u_html-3.0.so.0"
  )
  _wx_gtk3_libs=(
    "${_wx}/libwx_gtk3u_html-3.0.so.0"
    "${_wx}/libwx_gtk3u_gl-3.0.so.0"
    "${_wx}/libwx_gtk3u_core-3.0.so.0"
    "${_wx}/libwx_gtk3u_core-3.0.so.0"
    "${_wx}/libwx_gtk3u_xrc-3.0.so.0"
    "${_wx}/libwx_gtk3u_stc-3.0.so.0"
    "${_wx}/libwx_gtk3u_richtext-3.0.so.0"
    "${_wx}/libwx_gtk3u_ribbon-3.0.so.0"
    "${_wx}/libwx_gtk3u_propgrid-3.0.so.0"
    "${_wx}/libwx_gtk3u_qa-3.0.so.0"
    "${_wx}/libwx_gtk3u_adv-3.0.so.0"
    "${_wx}/libwx_gtk3u_media-3.0.so.0"
    "${_wx}/libwx_gtk3u_aui-3.0.so.0"
  )
  _libs=(
    "${_wx_libs[@]}"
    "${_wx_gtk2_libs[@]}"
  )
  env \
    GDK_BACKEND="x11" \
    LD_PRELOAD="${_libs[*]}" \
    __GL_THREADED_OPTIMIZATIONS=1 \
    mesa_glthread="true" \
    MESA_NO_ERROR=1 \
    PCSX2
}

_launch $@
