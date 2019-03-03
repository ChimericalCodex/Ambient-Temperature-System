# @executor Any player
# 
# Removes a player from being tracked by ATS.

# Remove bossbar for all players, untag this player as being tracked by ATS, then
# add bossbar for all players being tracked by ATS. Note: This won't work for players
# who aren't logged on, in the case of a multiplayer scenario. To handle this case, 
# body_temp is always set for players in ats:tick_player_update.
bossbar set ats:body_temp players
tag @s remove ats
bossbar set ats:body_temp players @a[tag=ats]
