# Initializes persistent settings used by the system.
# This includes scoreboards, bossbars, etc.

# Body temperature gauge. Shows the player's current body temperature
bossbar add ats:body_temp "Body Temperature"
bossbar set ats:body_temp color white
bossbar set ats:body_temp max 1200000
bossbar set ats:body_temp style notched_6

# Ambient temperature gauge. Shows the temperature around the player.
bossbar add ats:ambient_temp "Ambient Temperature"
bossbar set ats:ambient_temp color yellow
bossbar set ats:ambient_temp max 1200000
bossbar set ats:ambient_temp style notched_6

scoreboard objectives add CONST dummy
scoreboard objectives add body_temp dummy
scoreboard objectives add area_temp dummy
scoreboard objectives add ambient_temp dummy
scoreboard objectives add temp_rate dummy
scoreboard objectives add ff_dist dummy
scoreboard objectives add ff_temp dummy
scoreboard objectives add ff_count dummy
scoreboard objectives add cold_res dummy
scoreboard objectives add heat_res dummy


################################################################################
# [OPTION] Temperature rate of change.
#       Inverse scaling factor for temperature rate of change. If set to 1, body
#       temperature will be set to ambient temperature in a single tick; If set to 2,
#       body temperature will adjust halfway to ambient temperature in a single tick; Etc.
#       (ignoring any cold/heat resistance modifiers)
scoreboard players set CONST_TEMP_RATE CONST 1000
################################################################################


################################################################################
# [OPTION] Temperature resistance normalization boost
#       Scaling factor for how much more effective temperature resistance is for 
#       normalizing temperature. For instance, cold resistance means that the player
#       both cools off slower and heats up quicker. This factor adjusts how much
#       faster they would heat up. Does the same for heat resistance and cooling down.
scoreboard players set CONST_RES_BOOST CONST 10
################################################################################


scoreboard players set CONST_DIST_SCALE CONST 100
#       This value represents a distance of 1 block, internally, and is used in
#       calculations involving heat propagation over a distance. This exists purely
#       as a way to get more precision over distances (e.g. 100 gives precision up to
#       1/100th of a block). Currently this added precision is unused.


# For use with "/scoreboard players operation". Generally used for percentages
scoreboard players set CONST_100 CONST 100


#execute as @a[tag=!init] run bossbar set advent:countdown players @a


