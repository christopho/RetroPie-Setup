#!/usr/bin/env bash

# This file is part of The RetroPie Project
# 
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="gemrb"
rp_module_desc="gemrb - open-source implementation of Infinity Engine"
rp_module_menus="4+"
rp_module_flags=""

function depends_gemrb() {
    getDepends python-dev libopenal-dev libsdl1.2-dev cmake libpng12-dev libfreetype6-dev
}

function sources_gemrb() {
    gitPullOrClone "$md_build" https://github.com/gemrb/gemrb.git
}

function build_gemrb() {
    mkdir build
    cd build
    cmake .. -DPREFIX="$md_inst" -DCMAKE_BUILD_TYPE=Release -DFREETYPE_INCLUDE_DIRS=/usr/include/freetype2/
    make
}

function install_gemrb() {
    cd build
    make install
}

function configure_gemrb() {
    mkRomDir "ports/baldurs1"
    mkRomDir "ports/baldurs2"
    mkRomDir "ports/icewind1"
    mkRomDir "ports/icewind2"
    mkRomDir "ports/planescape"
    mkRomDir "ports/cache"

    addPort "$md_id" "BaldursGate1" "Baldurs Gate 1" "$md_inst/bin/gemrb -C $configdir/BaldursGate1/GemRB.cfg"
    addPort "$md_id" "BaldursGate2" "Baldurs Gate 2" "$md_inst/bin/gemrb -C $configdir/BaldursGate2/GemRB.cfg"
    addPort "$md_id" "Icewind1" "Icewind Dale 1" "$md_inst/bin/gemrb -C $configdir/Icewind1/GemRB.cfg"
    addPort "$md_id" "Icewind2" "Icewind Dale 2" "$md_inst/bin/gemrb -C $configdir/Icewind2/GemRB.cfg"
    addPort "$md_id" "Planescape" "Planescape Torment" "$md_inst/bin/gemrb -C $configdir/Planescape/GemRB.cfg"

    #create Baldurs Gate 1 configuration
    cat > "$configdir/BaldursGate1/GemRB.cfg" << _EOF_
GameType=bg1
GameName=Baldurs Gate 1
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=0
CaseSensitive=1
GamePath=$romdir/ports/baldurs1/
CD1=$romdir/ports/baldurs1/
CachePath=$romdir/ports/cache/
_EOF_

    #create Baldurs Gate 2 configuration
    cat > "$configdir/BaldursGate2/GemRB.cfg" << _EOF_
GameType=bg2
GameName=Baldurs Gate 2
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=0
CaseSensitive=1
GamePath=$romdir/ports/baldurs2/
CD1=$romdir/ports/baldurs2/data/
CachePath=$romdir/ports/cache/
_EOF_

    #create Icewind 1 configuration
    cat > "$configdir/Icewind1/GemRB.cfg" << _EOF_
GameType=auto
GameName=Icewind Dale 1
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=0
CaseSensitive=1
GamePath=$romdir/ports/icewind1/
CD1=$romdir/ports/icewind1/Data/
CD2=$romdir/ports/icewind1/CD2/Data/
CD3=$romdir/ports/icewind1/CD3/Data/
CachePath=$romdir/ports/cache/
_EOF_

    #create Icewind2 configuration
    cat > "$configdir/Icewind2/GemRB.cfg" << _EOF_
GameType=iwd2
GameName=Icewind Dale 2
Width=800
Height=600
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=0
CaseSensitive=1
GamePath=$romdir/ports/icewind2/
CD1=$romdir/ports/icewind2/data/
CachePath=$romdir/ports/cache/
_EOF_

    #create Planescape configuration
    cat > "$configdir/Planescape/GemRB.cfg" << _EOF_
GameType=pst
GameName=Planescape Torment
Width=640
Height=480
Bpp=32
Fullscreen=0
TooltipDelay=500
AudioDriver = openal
GUIEnhancements = 15
DrawFPS=0
CaseSensitive=1
GamePath=$romdir/ports/planescape/
CD1=$romdir/ports/planescape/data/
CachePath=$romdir/ports/cache/
_EOF_

    chown $user:$user "$configdir/BaldursGate1/GemRB.cfg"
    chown $user:$user "$configdir/BaldursGate2/GemRB.cfg"
    chown $user:$user "$configdir/Icewind1/GemRB.cfg"
    chown $user:$user "$configdir/Icewind2/GemRB.cfg"
    chown $user:$user "$configdir/Planescape/GemRB.cfg"
}