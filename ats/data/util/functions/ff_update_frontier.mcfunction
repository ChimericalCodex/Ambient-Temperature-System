# @executor Any ff_marker_new
#
# Increments this marker's distance and makes it a frontier marker
# instead of a new marker.

scoreboard players operation @s ff_dist += CONST_DIST_SCALE CONST
#scoreboard players add @s ff_dist 1

tag @s add ff_marker_f
tag @s remove ff_marker_new
