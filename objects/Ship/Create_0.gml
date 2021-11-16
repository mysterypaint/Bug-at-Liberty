/// @description 
hsp = 0;
vsp = 0;

move_speed = 2;

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