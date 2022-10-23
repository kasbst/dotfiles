#!/bin/ksh

_orn="#F1FA8C"
_red="#FF5555"

set -A _nic "em0" "iwx0"

# Functions ------------------------------------------------------------

function battery {
	battcharge=$(apm -a)
	battery=$(apm -l)
	if [[ $battcharge -eq 1 && $battery -lt 100 ]]; then
           echo -n "| Battery (Charging) ${battery}%"
	elif [[ $battcharge -eq 0 && $battery -lt 30 ]]; then
	   echo -n "| Battery: %{F$_red}${battery}%%{F-}"
	else
	   echo -n "| Battery ${battery}%"
	fi
}

function datetime {
	[[ $(date "+%H") -ge 6 && $(date "+%H") -le 22 ]] \
	  && echo -n "%{F-}" \
	  || echo -n "%{F$_orn}"
	echo -n "|" $(date '+%a. %e %b. %Y  %H:%M %Z')%{F-}
}

function network {
	if [[ -z "$(ifconfig ${_nic[0]} | grep 'status: active')" ]]; then
	   _id=$(ifconfig ${_nic[1]} | grep ieee80211: | awk '{print $3}')
	   _s=$(ifconfig ${_nic[1]} | grep ieee80211: | awk '{print $8}')
           
	   echo -n "| NW: $_id $_s"
	else
           echo -n "| NW: Eth - ${_nic[0]}"
	fi
}

function sensor {
	_t=$(sysctl -n hw.sensors.cpu0.temp0 | awk '{ printf "%d", $1 }')
	_c=$(sysctl -n hw.cpuspeed | awk '{ printf "%d", $1 }')
	echo -n "CPU: ($_c MHz) $_t°C"
}

function memory {
	_m=$(vmstat | awk '(NR==2){for(i=1;i<=NF;i++)if($i=="fre"){getline; print $i}}')
	echo -n "| Free Mem: $_m"
}

function volume {
	_v=$(sndioctl -n output.level | awk '{ print int($0*100) }')
	if [[ $(sndioctl -n output.mute) -eq 1 ]]; then
	    echo -n "| Volume: MUTED"
	else
	    echo -n "| Volume: $_v%"
	fi
}

case $1 in
	"battery") battery;;
	"datetime") datetime;;
	"network") network;;
	"sensor") sensor;;
	"memory") memory;;
	"volume") volume;;
	*)
		echo "You forgot to tell me what to do!"
		exit 1
	;;
esac

exit 0
#EOF
