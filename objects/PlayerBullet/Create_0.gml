/// @description Insert description here
event_inherited();

enum BulletTypes {
	LADYBUG,
	DRAGONFLY,
	BUTTERFLY,
	BEE,
	FIREFLY,
	STAG_BEETLE,
	MAX
};

bullet_type = BulletTypes.LADYBUG;

hsp = 4;
hsp_carry = 0;
vsp = 0;
vsp_carry = 0;
atk_stat = 0.1; // How much to damage enemies by

parent_id = noone;

image_speed = 0;
img_index = 0;
img_speed = 0;

extra_bullet = false;

bullet_butterfly_life_timer = 9;
bullet_butterfly_speed = 4;
bullet_bee_vertical_timer = 60;
bullet_bee_missile_hsp = 0;
bullet_bee_missile_hsp_rate = 0.4;
death_time = -1;
grav = 0.08;
grav_max = 7;
gravity_enabled = false;
delay_timer = 0;