# Expands all frontier flood fill markers in every direction.
#
# ff_marker     - Generic tag on all markers
# ff_marker_new - New marker summoned this function call
# ff_marker_f   - Frontier marker
#
# On each iteration, all frontier markers will expand, make new markers, which
# then become new frontier markers.
# This function assumes that all ff_marker_f have the same ff_dist.

# Invulnerable:1b,Marker:1b,NoGravity:1b,

execute at @e[tag=ff_marker_f] run summon minecraft:armor_stand ~1 ~ ~ {Tags:["ff_marker_new"],Invisible:1b,Marker:1b}
execute at @e[tag=ff_marker] run kill @e[tag=ff_marker_new,tag=!ff_marker,distance=..0.25]
tag @e[tag=ff_marker_new] add ff_marker

execute at @e[tag=ff_marker_f] run summon minecraft:armor_stand ~ ~1 ~ {Tags:["ff_marker_new"],Invisible:1b,Marker:1b}
execute at @e[tag=ff_marker] run kill @e[tag=ff_marker_new,tag=!ff_marker,distance=..0.25]
tag @e[tag=ff_marker_new] add ff_marker

execute at @e[tag=ff_marker_f] run summon minecraft:armor_stand ~ ~ ~1 {Tags:["ff_marker_new"],Invisible:1b,Marker:1b}
execute at @e[tag=ff_marker] run kill @e[tag=ff_marker_new,tag=!ff_marker,distance=..0.25]
tag @e[tag=ff_marker_new] add ff_marker

execute at @e[tag=ff_marker_f] run summon minecraft:armor_stand ~-1 ~ ~ {Tags:["ff_marker_new"],Invisible:1b,Marker:1b}
execute at @e[tag=ff_marker] run kill @e[tag=ff_marker_new,tag=!ff_marker,distance=..0.25]
tag @e[tag=ff_marker_new] add ff_marker

execute at @e[tag=ff_marker_f] run summon minecraft:armor_stand ~ ~-1 ~ {Tags:["ff_marker_new"],Invisible:1b,Marker:1b}
execute at @e[tag=ff_marker] run kill @e[tag=ff_marker_new,tag=!ff_marker,distance=..0.25]
tag @e[tag=ff_marker_new] add ff_marker

execute at @e[tag=ff_marker_f] run summon minecraft:armor_stand ~ ~ ~-1 {Tags:["ff_marker_new"],Invisible:1b,Marker:1b}
execute at @e[tag=ff_marker] run kill @e[tag=ff_marker_new,tag=!ff_marker,distance=..0.25]
tag @e[tag=ff_marker_new] add ff_marker

# Update distances and make new markers into frontier markers.
scoreboard players operation @e[tag=ff_marker_new] ff_dist = @e[tag=ff_marker_f,limit=1] ff_dist
tag @e[tag=ff_marker_f] remove ff_marker_f
execute as @e[tag=ff_marker_new] run function util:ff_update_frontier

################################################################################
# [OPTION] Disabling this will make walls no longer block radiant heat.
#
# Mark all markers that intersect non heat-permeable blocks as non-frontier markers
execute as @e[tag=ff_marker] positioned as @s run function util:tag_permeable
tag @e[tag=ff_marker_f,tag=!permeable] remove ff_marker_f
################################################################################
