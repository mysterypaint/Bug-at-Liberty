/// @description Insert description here
var _x = camera_get_view_x(view_camera[0]);
var _y = camera_get_view_y(view_camera[0]);

if (time_alive > active_frame) {
	img_speed = 0.2;
	draw_sprite(sprWind, img_index, _x, _y);
	if (!played_wind_blow_sfx) {
		sfx_play(sfxPrayingMantisWindAttack, 0, true);
		played_wind_blow_sfx = true;
	}
}

var _lerp_x = lerp(0, 26, fan_x_off / 15);
var _game_width = Game.base_res_width;

for (var _i = 0; _i < 3; _i++)
	draw_sprite(sprFan, img_index, _x + _game_width - _lerp_x, _y + fan_y[_i]);