/// @description Insert description here
if (activated) {
	draw_me = true;
	
	if (Game.state != GameStates.PAUSED)
		bullet_shooting();
}

img_index += img_speed * Game.dt;
if (img_index + img_index_offset > ani_max_frames)
	img_index = 0;