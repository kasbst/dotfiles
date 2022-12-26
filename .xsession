xsetroot -solid '#4C566A'

xrdb -merge .Xdefaults

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# graphic acceleration for Firefox
export MOZ_ACCELERATED=1
export MOZ_WEBRENDER=1

# allow web assembly in Chromium
export ENABLE_WASM=1

# lock display after a period of inactivity
xidle -timeout 3600 &

# pump up the volume
doas mixerctl outputs.master=255,255

/home/karol/scripts/polybar-start.sh

/home/karol/scripts/setup-screens.sh

xset b off

exec cwm
