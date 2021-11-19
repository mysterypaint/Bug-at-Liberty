/// @description Insert description here
if (img_index >= 3 && img_index < 4) {
	if (!instance_exists(PilotBug)) {
		var _pilot = instance_create_depth(x + 1, y, depth - 1, PilotBug);
		_pilot.vsp = -0.4;
	}
} else if (img_index >= 4 && img_index < 5) {
	with (Ship)
		draw_me = false;
}

if (img_index > ani_max_frames)
	instance_destroy();

img_index += img_speed * Game.dt;

x += Camera.prev_move_x * Game.dt;
y += Camera.prev_move_y * Game.dt;