# @executor Any player.
#
# Advances the temperature simulation a single tick for this player.


# Temperature updates
scoreboard players operation @s temp_rate = @s ambient_temp
scoreboard players operation @s temp_rate -= @s body_temp


# Clamp cold/heat resistance to be between 0 and 100.
scoreboard players set @a[scores={cold_res=..-1}] cold_res 0
scoreboard players set @a[scores={cold_res=101..}] cold_res 100
scoreboard players set @a[scores={heat_res=..-1}] heat_res 0
scoreboard players set @a[scores={heat_res=101..}] heat_res 100


# Player cold_res/heat_res is an integer percentage out of 100. 0 means no resistance, 100
# means total resistance. 
# __RES__ cold_res - The fraction of resistance against cooling, by cold resistance
# __RES__ heat_res - The fraction of resistance against warming, by heat resistance
scoreboard players set __RES__ cold_res 100
scoreboard players set __RES__ heat_res 100
scoreboard players operation __RES__ cold_res -= @s cold_res
scoreboard players operation __RES__ heat_res -= @s heat_res


# These are heat and cold resistance, multiplied by a factor so that heating up is
# faster for cold resistance, or vice versa for cooling off/heat resistance.
scoreboard players operation __BOOSTED__ heat_res = @s heat_res
scoreboard players operation __BOOSTED__ cold_res = @s cold_res
scoreboard players operation __BOOSTED__ heat_res *= CONST_RES_BOOST CONST
scoreboard players operation __BOOSTED__ cold_res *= CONST_RES_BOOST CONST


# __NET__ cold_res - Resistance against cooling + boost to cooling from heat resistance
# __NET__ heat_res - Resistance against heating + boost to heating from cold resistance
scoreboard players operation __NET__ cold_res = __RES__ cold_res
scoreboard players operation __NET__ cold_res += __BOOSTED__ heat_res
scoreboard players operation __NET__ heat_res = __RES__ heat_res
scoreboard players operation __NET__ heat_res += __BOOSTED__ cold_res


# Apply the relevant factor, depending on whether the player's temperature is
# decreasing or increasing
scoreboard players operation @s[scores={temp_rate=..-1}] temp_rate *= __NET__ cold_res
scoreboard players operation @s[scores={temp_rate=1..}] temp_rate *= __NET__ heat_res
scoreboard players operation @s temp_rate /= CONST_100 CONST


# Determine final temperature rate and apply temperature change to body
scoreboard players operation @s temp_rate /= CONST_TEMP_RATE CONST
scoreboard players operation @s body_temp += @s temp_rate


# GUI update
execute store result bossbar ats:body_temp value run scoreboard players get @s body_temp
execute store result bossbar ats:ambient_temp value run scoreboard players get @s ambient_temp
