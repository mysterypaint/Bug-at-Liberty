/// @description 
event_inherited();

hsp = 0;
vsp = 0;

move_speed = 2;

dead = false;
death_timer = -1;
death_timer_reset = 370;
init_player_reset = 10; // Frames it takes for the player to regain control when they spawn
init_player = init_player_reset;

enum Fighters {
	LADYBUG,
	DRAGONFLY,
	TERMITE,
	BEE,
	MOSQUITO,
	STAG_BEETLE,
	MAX
};

current_fighter = Fighters.LADYBUG;

spr_x_off = sprite_get_xoffset(sprite_index);
spr_y_off = sprite_get_yoffset(sprite_index);

shoot_x_off = 12;
shoot_y_off = 14;

bullet_count = 0;
bullet_count_max = 3;
bullet_count_two = 0;
bullet_count_two_max = 4;
bullet_type = 0;

enum ShipAnimations {
	NEUTRAL,
	DOWN,
	UP
};

img_index = 0;
img_index_offset = 0;
img_speed = 0.7;
img_ani_frames_max = 2;

depth = 0;

helpers_activated = -1;

for (var _i = 29; _i >= 0; _i--) {
	player_ghost_x[_i] = x;
	player_ghost_y[_i] = y;
}

for (var _i = 2; _i >= 0; _i--) {
	var _this_helper = instance_create_depth(x, y, depth - 1, HelperBug);
	_this_helper.my_id = _i;
	_this_helper.parent_id = id;
	_this_helper.activated = false;
	helpers[_i] = _this_helper;	
}