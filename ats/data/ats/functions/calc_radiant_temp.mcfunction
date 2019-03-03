# @executor An ff_marker
#
# Calculates the temperature for this marker's position. This is dependent on
# the heat source at this position as well as the distance of this marker.


################################################################################
# [OPTION] Heat Source Values
# These are the heat values of blocks that the player will feel when standing
# directly adjacent to them. Add new blocks by duplicating any of the lines below
# and changing the value.
execute if block ~ ~ ~ minecraft:redstone_torch run scoreboard players set @s ff_temp 80000
execute if block ~ ~ ~ minecraft:torch run scoreboard players set @s ff_temp 200000
execute if block ~ ~ ~ minecraft:glowstone run scoreboard players set @s ff_temp 300000
execute if block ~ ~ ~ minecraft:magma_block run scoreboard players set @s ff_temp 200000
execute if block ~ ~ ~ minecraft:fire run scoreboard players set @s ff_temp 700000
execute if block ~ ~ ~ minecraft:lava run scoreboard players set @s ff_temp 900000

# Special case: Furnace. Stores a default value of 0 in CONST, then updates it to be
# the remaining burn time of the furnace, if there is a furnace here. If the value is 0
# (either because there's not a furnace here and the default value was never updated, or
# because there is a furnace here but it's not burning), then nothing happens. If the 
# value is positive, then the temperature is set accordingly.
scoreboard players set @s CONST 0
execute if block ~ ~ ~ minecraft:furnace store result score @s CONST run data get block ~ ~ ~ BurnTime
scoreboard players set @s[scores={CONST=1..}] ff_temp 500000
################################################################################


# Scale by distance constant. Having this after makes the values up above have
# meaningful values (i.e. they correspond to actual temperatures), and also makes
# them independent of whatever the distance scaling factor is.
scoreboard players operation @s ff_temp *= CONST_DIST_SCALE CONST


################################################################################
# [OPTION] Enable this to disable radiant heat falloff
#scoreboard players operation @s ff_dist = CONST_DIST_SCALE CONST
################################################################################


# Scale distance
# [DEPRECATED] The scaled amount is now added during flood fill execution
#scoreboard players operation @s ff_dist *= CONST_DIST_SCALE CONST


################################################################################
# [OPTION] Enable these to enable inverse square law for heat falloff
# Square, then divide by distance scale so that distance scale isn't factored
# in twice (due to it already being included before squaring).
#scoreboard players operation @s ff_dist *= @s ff_dist
#scoreboard players operation @s ff_dist /= CONST_DIST_SCALE CONST
################################################################################


# Scale by inverse distance
scoreboard players operation @s ff_temp /= @s ff_dist
