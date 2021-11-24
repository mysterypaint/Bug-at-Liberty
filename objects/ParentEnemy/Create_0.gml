/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

enum EnemyStates {
	UNLOADED,
	IDLE,
	MOVING,
	JUMPING,
	ATTACKING,
	DYING,
	FALLING,
	MAX
};

cam_bounds_x_min = Game.TILE_SIZE * 4;
cam_bounds_y_min = Game.TILE_SIZE * 4;
cam_bounds_x_max = Game.base_res_width + Game.TILE_SIZE * 4;
cam_bounds_y_max = Game.base_res_height + Game.TILE_SIZE * 4;

state = EnemyStates.UNLOADED;
can_hurt_player = false;
has_small_explosion = true;

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

ani_max_frames = sprite_get_number(spr_index);
time_alive = 0;

hsp = 0;
vsp = 0;

hp = 7;