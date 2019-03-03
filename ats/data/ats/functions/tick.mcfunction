# Advances the temperature simulation a single tick for all players tracked by ATS.
# Also updates GUI based on items that the player is holding.

execute as @a[tag=ats] run function ats:tick_player


# Display ambient temperature bar for players holding thermometer
tag @a remove thermometer
tag @a[nbt={SelectedItem:{tag:{CIID:"thermometer"}}}] add thermometer
tag @a[nbt={Inventory:[{Slot:-106b,tag:{CIID:"thermometer"}}]}] add thermometer
bossbar set ats:ambient_temp players @a[tag=thermometer]
