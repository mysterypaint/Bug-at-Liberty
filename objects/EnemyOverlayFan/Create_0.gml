/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

cam_bounds_x_min = Game.TILE_SIZE * 4;
cam_bounds_y_min = Game.TILE_SIZE * 4;
cam_bounds_x_max = Game.base_res_width + Game.TILE_SIZE * 4;
cam_bounds_y_max = Game.base_res_height + Game.TILE_SIZE * 4;

state = EnemyStates.IDLE;
can_hurt_player = false;

spr_index = sprite_index;
img_index = 0;
img_index_offset = 0;
img_speed = 0;
img_angle = 0;
img_xscale = 1;
img_yscale = 1;
img_alpha = 1;
img_color = c_white;
img_diagonal_angle = false;
img_xoff = 0;
shake_rate = 1;

ani_max_frames = sprite_get_number(spr_index);
time_alive = 0;

hsp = 0;
vsp = 0;

hp = -2;

fan_y[2] = 21;
fan_y[1] = 73;
fan_y[0] = 125;
active_frame = 50;
duration = 999;
fan_x_off = 0;