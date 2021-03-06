/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

cam_bounds_x_min = Game.TILE_SIZE * 4;
cam_bounds_y_min = Game.TILE_SIZE * 4;
cam_bounds_x_max = Game.base_res_width + Game.TILE_SIZE * 4;
cam_bounds_y_max = Game.base_res_height + Game.TILE_SIZE * 4;

state = EnemyStates.UNLOADED;
checked_if_already_has_this_bug = false; // Delete this cage if we already have this bug

spr_index = sprite_index;
img_index = 0;
img_index_offset = 0;
img_speed = 0.2;
img_angle = 0;
img_xscale = 1;
img_yscale = 1;
img_alpha = 1;
img_color = c_white;
img_diagonal_angle = false;

ani_max_frames = sprite_get_number(spr_index);
time_alive = 0;
destroyed_cage = false;
freed_sprite = sprTile;
freed_img_index = 0;
freed_img_speed = 0.2;
freed_ani_max_frames = 13;

hsp = 0;
vsp = 0;

hp = 4;

bug_type = 0; // 0 - dragonfly, 1 - butterfly, 2 - firefly