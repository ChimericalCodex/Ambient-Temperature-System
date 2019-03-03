# @executor Any player
# 
# Adds a player to be tracked by ATS.

tag @s add ats

scoreboard players set @s body_temp 600000
scoreboard players set @s area_temp 600000

bossbar set ats:body_temp players @s
