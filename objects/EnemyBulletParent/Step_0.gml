/// @description Insert description here
if ((x < Camera.x-5 && Camera.move_x >= 0) ||
	(x > Camera.x + Game.base_res_width + 5 && Camera.move_x >= 0) || 
	(y < Camera.y-128 && Camera.move_y >= 0) ||
	(y > Camera.y + Game.base_res_height + 5 && Camera.move_y >= 0) ||
	tile_place_meeting(x, y, 1)
	)
	instance_destroy();

speed = spd * Game.dt;

img_index += img_speed * Game.dt;