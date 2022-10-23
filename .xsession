xsetroot -solid '#4C566A'

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# graphic acceleration for Firefox
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

# allow web assembly in Chromium
export ENABLE_WASM=1

/home/karol/scripts/polybar-start.sh

xset b off

exec cwm
