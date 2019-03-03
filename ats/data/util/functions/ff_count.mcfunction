# @executor Any entity.
# 
# Stores the number of ff_markers in ff_count for this players.

scoreboard players set @s ff_count 0
execute at @e[tag=ff_marker] run scoreboard players add @s ff_count 1