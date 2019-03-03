# Creates a flood fill frontier marker at the current position, aligned to the center
# of the block.

execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon minecraft:armor_stand ~ ~ ~ {Tags:["ff_marker","ff_marker_f","ff_marker_seed"],Invisible:1b,Marker:1b}