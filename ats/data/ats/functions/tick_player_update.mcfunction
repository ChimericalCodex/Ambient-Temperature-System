# @executor Any player
# 
# Calculates and updates the ambient heat of this player.
# This function will repeat until all players tagged as "queued" have been processed.

# Remove player from queue
tag @s remove queued

# Ensure that the body_temp bossbar is visible
bossbar set ats:body_temp players @s

function util:ff_seed
################################################################################
# [OPTION] Radiant heat range. The number of lines lines is how many blocks
# heat radiates. Be aware that computation increase is cubic, so be careful not
# to make this too large.
function util:ff_expand
function util:ff_expand
function util:ff_expand
################################################################################

################################################################################
# [OPTION] Room size counter. 
# Enable to count the size of the space that the player is in. This has no
# functionality on its own, but can easily be used by checking the stored value.
#function util:ff_count
################################################################################

# Fix the seed marker's distance to be 1 instead of 0
#scoreboard players set @e[tag=ff_marker_seed] ff_dist 1
scoreboard players operation @e[tag=ff_marker_seed] ff_dist = CONST_DIST_SCALE CONST

# Calculate ambient temperature
execute as @e[tag=ff_marker] positioned as @s run function ats:calc_radiant_temp
scoreboard players set @s ambient_temp 0
################################################################################
# [OPTION] Total Heat Instead of Max Heat
# Enable the next line, and disable the line after it to enable this option.
# This option will make all heat sources around a player affect their ambient
# temperature, instead of just the highest heat source.
#scoreboard players operation @s ambient_temp += @e[tag=ff_marker] ff_temp
scoreboard players operation @s ambient_temp > @e[tag=ff_marker] ff_temp
################################################################################
scoreboard players operation @s ambient_temp += @s area_temp

# Clamp ambient temperature to bounds
scoreboard players set @s[scores={ambient_temp=..0}] ambient_temp 0
scoreboard players set @s[scores={ambient_temp=1200000..}] ambient_temp 1200000

# Do gear updates
function ats:gear_update

# Cleanup
function util:ff_reset

# Loop and execute this function for the next queued player
execute as @p[tag=queued] positioned as @s run function ats:tick_player_update
