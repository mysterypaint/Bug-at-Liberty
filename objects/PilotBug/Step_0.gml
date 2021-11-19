/// @description Insert description here
if (img_index >= 6 && img_index < 7)
	start_falling = true;

if (img_index >= ani_max_frames)
	img_index = loop_frame;

if (start_falling) {
	if (vsp < grav)
		vsp += 0.2;
}

y += vsp;

if (y > Camera.y + Game.base_res_height * 2)
	instance_destroy();

img_index += img_speed * Game.dt;