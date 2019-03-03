# @executor Any player.
#
# Checks what gear the player has equipped and updates resistances and GUI accordingly.
# At the end of this function's execution, cold_res and heat_res for this player should
# be set to the values that will be used in calculation.

scoreboard players set @s cold_res 0
scoreboard players set @s heat_res 0

################################################################################
# [OPTION] Temperature Resistant Gear
# Add, remove, or modify lines to detect gear that the player is wearing/holding,
# and modify resistances accordingly.

scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["cr5"]}}]}] cold_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["cr10"]}}]}] cold_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["cr15"]}}]}] cold_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["cr20"]}}]}] cold_res 20

scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["cr5"]}}]}] cold_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["cr10"]}}]}] cold_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["cr15"]}}]}] cold_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["cr20"]}}]}] cold_res 20

scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["cr5"]}}]}] cold_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["cr10"]}}]}] cold_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["cr15"]}}]}] cold_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["cr20"]}}]}] cold_res 20

scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["cr5"]}}]}] cold_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["cr10"]}}]}] cold_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["cr15"]}}]}] cold_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["cr20"]}}]}] cold_res 20



scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["hr5"]}}]}] heat_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["hr10"]}}]}] heat_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["hr15"]}}]}] heat_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:100b,tag:{Tags:["hr20"]}}]}] heat_res 20

scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["hr5"]}}]}] heat_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["hr10"]}}]}] heat_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["hr15"]}}]}] heat_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:101b,tag:{Tags:["hr20"]}}]}] heat_res 20

scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["hr5"]}}]}] heat_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["hr10"]}}]}] heat_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["hr15"]}}]}] heat_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:102b,tag:{Tags:["hr20"]}}]}] heat_res 20

scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["hr5"]}}]}] heat_res 5
scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["hr10"]}}]}] heat_res 10
scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["hr15"]}}]}] heat_res 15
scoreboard players add @s[nbt={Inventory:[{Slot:103b,tag:{Tags:["hr20"]}}]}] heat_res 20




# Display ambient temperature bar for players holding thermometer.
bossbar set ats:ambient_temp players
# Note that the next 4 lines are duplicated in ats:tick. This is so that the system is
# quick and responsive to showing the ambient temperature bar, and slower to take it away.
# It also means that animations of the bar adjusting will still animate.
tag @a remove thermometer
tag @a[nbt={SelectedItem:{tag:{CIID:"thermometer"}}}] add thermometer
tag @a[nbt={Inventory:[{Slot:-106b,tag:{CIID:"thermometer"}}]}] add thermometer
bossbar set ats:ambient_temp players @a[tag=thermometer]



