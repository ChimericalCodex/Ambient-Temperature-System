# Ambient Temperature System #

A Minecraft 1.13+ datapack for simulating player temperature mechanics. 

This datapack was created with the intent to be used in custom maps to provide
an extra dimension to custom environments, armor, and items.

[Download Demo World](https://www.mediafire.com/file/1vmguuiekhuw3u9/Ambient_Temperature_System_Demo.zip/file)

### Features (v1.0) ###
- Heat radiation with physical blocking
- Customizable heat sources, heat ranges, heat permeable blocks
- Customizable heat falloff (none, inverse, inverse square)
- Customizable temperature normalization (linear/inverse curves, rate of change)
- Cold/Heat Resistance attributes for armor and items
- Multiplayer compatible
- Expandible core system

# How to Use #
Simply download this repository (green button, top right), and copy the
entire "ats" folder into the "datapacks" folder of a Minecraft save
file.

In-game, run `/function ats:init` to initialize relevant scoreboard and
GUI settings. Then, set up a repeating command block to execute
`/function ats:tick` every tick. Next, set up a clock or another repeating
command block to execute `/function ats:tick_update`. Finally, run
`/function ats:add_player`, which will mark the executing player to be tracked
by the system.

`tick_update` is separated from `tick` since it is the most computationally
expensive. This way, it can be run at a slower rate depending on the needs of
the map. Generally, executing it every tick is still fine, although armor
stands may occasionally be briefly visible when Minecraft can't keep up.

### How It Works ###

The central mechanic of this system is simple: All players have a *Body
Temperature*, an *Ambient Temperature*, and an *Area Temperature*. All of these
values range from 0 to 1200000 (these numbers are chosen to give a fine degree
of precision, and also since 12 is nicely divisible by 2,3,4). Area temperature
is the base temperature of the area a player is in, and must be set manually to
whatever the user wants. Ambient temperature is automatically set by the system
to be area temperature + temperature of surrounding heat sources. Over time,
the body temperature of any player will change to approach that of their
ambient temperature.

Note that body temperature can be freely modified at any time. For instance,
if you want a special potion that warms the player, you can simply add some
value to `body_temp` and the system will take care of the rest.

In addition, players have two new attributes: *Cold Resistance* and *Heat
Resistance*. These are both percentage values that change how slowly/quickly a
player's body temperature changes. For example, cold resistance will make a
player cool down slower and heat up quicker. 

# Customization #

This datapack provides a wide array of customization to how its mechanics work.
This section details which files to modify to achieve certain changes. 
Function files will contain sections marked by "[OPTION]", along with detailed
instructions on what to do.

### Temperature GUI ###
`ats/data/ats/functions/init.mcfunction`

All bossbar settings can be found at the top of this function.

### Temperature Rate of Change ###
`ats/data/ats/functions/init.mcfunction`

This is the main option for controlling how fast/slow players cool off/heat up.

If set to 1, body temperature will be set to ambient temperature in a single 
tick, if set to 2, body temperature will adjust halfway to ambient temperature
in a single tick, etc. (ignoring any cold/heat resistance modifiers). By
default this is set to 1000.

### Radiant Heat Range ###
`ats/data/ats/functions/tick_player_update.mcfunction`

This option determines how far heat will eminate from heat sources. By default,
this value is 3 blocks. Be aware that computational increase is cubic, so be
careful not to make this too large.

### Temperature Resistance Normalization Boost ###
`ats/data/ats/functions/init.mcfunction`

Scaling factor for how much more effective temperature resistance is for
normalizing temperature. For instance, having cold resistance means that the
player both cools off slower and heats up quicker. This factor adjusts how much
heating up is boosted compared to cooling off. It does the same for heat
resistance and cooling down. By default, this is 10.

### Heat Source Values ###
`ats/data/ats/functions/calc_radiant_temp.mcfunction`

The lines at the top of this file control the amount of heat radiated from
certain blocks. Lines can be added, removed, or adjusted as needed. The
temperature values set are the temperatures that a player would feel when
standing directly next to/inside one of these blocks.

Reminder: The radiant heat from blocks is added to area temperature during
calculations.

### Radiant Heat Falloff ###
`ats/data/ats/functions/calc_radiant_temp.mcfunction`

There are two options for this, both located at the bottom of the file. 

The first can be enabled to disable radiant heat falloff. This means that
players will feel the same amount of heat standing directly next to a heat 
source as they will standing just on the edge of its range. This option is
disabled by default.

The second can be enable to enable the inverse square law for heat falloff.
This means that the heat radiating from a heat source will falloff more
sharply, so players will have to stand closer to get the full effect. This is
more physically accurate to real life, but doesn't necessarily make for a
better experience, so it is disabled by default.

### Temperature Resistant Gear ###
`ats/data/ats/functions/gear_update.mcfunction`

Temperature resistance is calculated by detecting what the player is
wearing/holding and then adding resistances accordingly. This file has a
simple demonstration of how that might work. It detects armor that the player
is wearing, and uses the tags on that armor to adjust that player's resistance.
For example, a piece of gear with tag `cr5` gives 5% cold resistance when worn.
A piece of gear with tag `hr20` gives 20% heat resistance when worn. This is
just one style of gear attributes and you can modify this file so that it work
however you like.

Note that this function resets `cold_res` and `heat_res` and calculates each
from scratch every time. This means that if you want to have time dependent
resistant bonuses (for example, a potion of cold resistance), you will have to
add your own scoreboard timer, have it tick down in `ats:tick`, and then add
the appropriate resistances in this function, if the timer hasn't run out.

### Heat Permeable Blocks ###
`ats/data/util/functions/tag_permeable.mcfunction`

This file determines which blocks heat can permeate through. This essentially
deals with solid vs. non-solid blocks. For instance, a player should be able to
feel the heat of a fire even if a sign in inbetween them, but a player should
not be able to be warmed by a fire on the other side of a stone wall.

On the subject of performance, if you know that the player will only ever be
interacting with a certain few non-solid blocks, it would be best to only
include those in this file, and remove any others. 

### Total Heat Instead of Max Heat ###
`ats/data/ats/functions/tick_player_update.mcfunction`

Currently ambient temperature is dependent on the maximum heat source near the
player. This means that if a player is standing directly next to a large fire,
they won't feel the heat of some small torches nearby. This was a decision to
make the system easier to balance for map makers while also making it easier to
understand by players. This can easily be changed though so that all heat
sources count.

This can be changed in the section marked "Calculate ambient temperature" by 
enable the commented out line, and disabling the line just after it. Note that
you will probably have to adjust heat source values/temperature rate of change
to account for this new calculation style.

# Potential Customization #

This datapack is also built with several elements that, while not currently
in use, could be used to add more complex features. These features may require
a little more work than just commenting in/out a single line or changing some
numbers.

### Linear Temperature Normalization ###
`ats/data/ats/functions/tick_player.mcfunction`

Currently the rate of change for body temperature normalization is proportional
to the difference between the current temperature and the ambient temperature.
This means that if body temperature and ambient temperature are very far apart,
then body temperature will normalize faster. Changing this so that it moves at
a constant, linear rate should be simple enough: At the top of this function,
just after `temp_rate` has `body_temp` subtracted from it, just detect whether
`temp_rate` is negative or positive and then set it to be some negative of
positive constant.

### Room Size Counter ###
`ats/data/ats/functions/tick_player_update.mcfunction`

Enabling this line will count the size of the room that a player is in
(dependent on what blocks are defined as permeable and what radiant heat range
is set to). This has implications for modeling heat build up. For instance,
players could get bonus cold resistance for being in rooms below a certain
size.

This could also be used for non-temperature related mechanics. For example,
players could need to be in spaces larger than some threshold or they will
suffer penalties for suffocation.

### Heat Conduction ###
`ats/data/util/functions/ff_update_frontier.mcfunction`

`ats/data/util/functions/ff_expand.mcfunction`

You may notice that distances used in heat radiation have extra precision.
Namely, distances increase by `CONST_DIST_SCALE` (default 100) rather than 1.
This gives the potential for precision up to 1/100th of a block. Although this
added precision is currently unused, it allows for fractional or "decayed"
distances to be used.

For example in the line
`scoreboard players operation @s ff_dist += CONST_DIST_SCALE CONST`,
every frontier marker in the flood fill is incremented by the equivalent of one
block. An alternative, however, would be to change how much is incremented
depending on what block it is. For instance, permeable blocks increment
normally, but solid blocks increment more if they are less heat conducbile. The
result is a system where heat can conduct through solid blocks (but are reduced
in strength). This would allow for setups like heated floors (heat sources
beneath floors made of conductive material).

Note that permeable block detection at the bottom of `ff_expand.mcfunction`
should be disabled if this route is taken.

# Technical Details #
This section gives an overview of some of the more technically interesting
components of this system for those that want to modify it, use its ideas
elsewhere, or that just want to understand what's happening beneath the hood.

### Flood Fill ###
`TODO`

# License #
This project is released under the MIT license. Basically, feel free to use, 
modify, and distribute anything in this repository! I just ask that you leave
`ats/README` intact so that other's can find their way to this project too.

