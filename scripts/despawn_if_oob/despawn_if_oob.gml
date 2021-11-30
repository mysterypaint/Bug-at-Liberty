// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function despawn_if_oob(){
	// De-spawn if too far away from the camera
	if ( (x < Camera.x - cam_bounds_x_min) ||
		(y < Camera.y - cam_bounds_y_min) ||
		(x > Camera.x + cam_bounds_x_max) ||
		(y > Camera.y + cam_bounds_y_max) ) {
			silent_death = true;
			instance_destroy();
	}
}