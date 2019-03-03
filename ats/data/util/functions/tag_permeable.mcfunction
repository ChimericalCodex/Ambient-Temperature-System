# This function tags @s if the current position is a "permeable block," as defined
# by this file. 
#
# Useful resource:
# https://minecraft.gamepedia.com/Solid_block#List_of_non-solid_blocks

tag @s remove permeable

################################################################################
# [OPTION] Heat Permeable Blocks
# This determines which blocks heat can radiate through. This should mostly be
# non-solid blocks that the player can normally walk through.
execute if block ~ ~ ~ minecraft:air run tag @s add permeable
execute if block ~ ~ ~ minecraft:fire run tag @s add permeable
execute if block ~ ~ ~ minecraft:torch run tag @s add permeable
execute if block ~ ~ ~ minecraft:redstone_torch run tag @s add permeable
execute if block ~ ~ ~ minecraft:stone_button run tag @s add permeable
execute if block ~ ~ ~ minecraft:redstone_torch run tag @s add permeable
execute if block ~ ~ ~ minecraft:ladder run tag @s add permeable
execute if block ~ ~ ~ minecraft:sign run tag @s add permeable
execute if block ~ ~ ~ minecraft:iron_bars run tag @s add permeable
execute if block ~ ~ ~ minecraft:oak_fence run tag @s add permeable
execute if block ~ ~ ~ minecraft:spruce_fence run tag @s add permeable
execute if block ~ ~ ~ minecraft:birch_fence run tag @s add permeable
execute if block ~ ~ ~ minecraft:jungle_fence run tag @s add permeable
execute if block ~ ~ ~ minecraft:acacia_fence run tag @s add permeable
execute if block ~ ~ ~ minecraft:nether_brick_fence run tag @s add permeable