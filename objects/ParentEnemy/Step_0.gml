/// @description Insert description here
if (hp <= 0)
	instance_destroy();

img_index += img_speed;
if (img_index > ani_max_frames)
	img_index = 0;