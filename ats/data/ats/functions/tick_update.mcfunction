# Calculates and updates the ambient heat of all players currently tracked by ATS.

tag @a[tag=ats] add queued
execute as @p[tag=queued] positioned as @s run function ats:tick_player_update
