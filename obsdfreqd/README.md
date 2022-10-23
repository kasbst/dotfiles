# obsdfreqd

Userland CPU frequency scheduling for OpenBSD >= 7.1

Forked from https://tildegit.org/solene/obsdfreqd.git

# TLDR

- clone this repository
- as root `make install`
- as root `rcctl enable obsdfreqd` and `rcctl stop apmd ; rcctl disable apmd`
- as root `rcctl start obsdfreqd`
- apmd can be kept but not with flag `-A`
- most interesting flag for end users is `-T`

# Compilation

As easy as `make`

# Running

Run `obsdfreqd` as root, quit with `Ctrl+C`.

# Installation

`make install` as root, enable the service using `rcctl enable
obsdfreqd`.

Start the service with `rcctl start obsdfreqd`.

**If you use `apmd` service, you have to start it either with `-H` or `-L` flag, otherwise it will start after **obsdfreqd** and set the performance policy to automatic and **obsdfreqd** will crash**.

# Usage

Parameters are applied when both plugged on the wall or on battery, parameters can have two values comma separated to give different values when plugged on wall and for when on battery.

- `-h` show usage
- `-v` verbose mode, CSV output if one wants to create diagrams
- `-d downstepfrequency` sets the steps removed every cycle when decaying, default to 100
- `-i inertia` sets the number of cycles after which the frequency will decay, 0 is the default
- `-m maxfrequency` sets the maximum frequency the CPU can reach in percent, 100% is default
- `-l minfrequency` sets the minimum frequency the CPU must be lowered to, 0% is default
- `-r threshold` sets the CPU usage in % that will trigger the frequency increase, 30% is the default
- `-s stepfrequency` sets the percent of frequency added every cycle when increasing, 10% is default
- `-t timefreq` sets the milliseconds between each poll, 300 is the default
- `-T maxtemperature` sets the temperature threshold under which the maximum frequency will be temporary lowered until the CPU cools down

**Example**:

`obsdfreqd -T 90,65` will start the daemon, when power is plugged in, maximum temperature is set to 90°C and 65°C when on battery.

# Explanation

The current algorithm works this way:

If CPU usage > `threshold`, increase frequency by `stepfrequency` up to `maxfrequency` every `timefreq` milliseconds and keep this frequency at least `inertia` cycles.

If CPU usage <= `threshold`, reduce frequency by `downstepfrequency` down to `minfrequency` every `timefreq` milliseconds when `inertia` reached 0. `inertia` lose one point every cycle the CPU usage is below `threshold`.

When flag `-T` is used, if the temperature exceeds the defined limit, the `maxfrequency` is decremented every cycle. When the current temperature is below the limit, the frequency limit is incremented at every cycle.

When switching from/to battery, values switch to mode specific when user defined.

# What is it doing?

**obsdfreqd** will change the perfpolicy sysctl to manual and will change the CPU frequency by polling every often (like 100ms) the CPU load and change the frequency accordingly, the perfpolicy is set to auto upon exit.

The end goal is to provide a feature rich CPU frequency scheduler for the following use case:

- battery saving while keeping responsiveness when needed (which apm -L doesn't do)
- reduce heat or electrical coil noise when on powerplug because the new default assuming mainboard and CPU can manage itself doesn't work well
- reduce power consumption for system on powerplug while staying performant enough
- provide setings for minimum and maximum frequency available in some automatic mode (people may have $reasons to use this)

# Relation to the OpenBSD project

obsdfreqd is available as a package in OpenBSD current.  The point of this progrm is to allow OpenBSD users to have a quiet and cool system which is not possible with the current code due to [this change in the kernel](https://marc.info/?l=openbsd-cvs&m=163563630606615&w=2).
