/// @description Insert description here
if (time_alive > active_frame) {
	white_screen = false;
	if (!played_sfx) {
		sfx_play(sfxEnemyPrayingMantisLightningStrike);
		played_sfx = true;
	}

	if (time_alive > active_frame + 15)
		instance_destroy();

	if (Game.tick % shake_rate == 0 && Game.dt > 0) {
		img_xoff = irandom(4);
	}
	
	height = clamp(time_alive * lightning_speed, 1, sprite_height);
	
	if (collision_rectangle(x, y, x + sprite_width - 1, y + height, Ship, false, false)) {
		if (!Game.debug) {
			with (Ship)
				kill_player();
		}
	}
	
	draw_sprite_part(spr_index, img_index + img_index_offset, 0, 0, sprite_width, height, x + img_xoff, y);
} else if (time_alive < 12) {
	if (time_alive % flash_rate == 0)
		white_screen = !white_screen;
	
	if (white_screen) {
		var _col = c_white;
		var _ts = Game.TILE_SIZE;
		var _x = camera_get_view_x(view_camera[0]);
		var _y = camera_get_view_y(view_camera[0]);
		draw_set_alpha(flash_alpha);
		draw_rectangle_color(_x - _ts, _y - _ts, _x + Game.base_res_width + _ts, _y + Game.base_res_height + _ts, _col, _col, _col, _col, false);
		draw_set_alpha(1);
	}
}