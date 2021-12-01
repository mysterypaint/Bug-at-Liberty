/// @description Insert description here
if (wait_timer > 0) {
	var _spr_warning_width = 7;
	var _spr_warning_height = 20;
	var _screen_side_y = Camera.y;
	
	if (moving_up)
		_screen_side_y = Camera.y + Game.base_res_height - _spr_warning_height;
	
	for (var _i = 0; _i < 9; _i++) {
		draw_sprite(sprWarning, caution_img_index, x - (5 * _spr_warning_width) + (_i * _spr_warning_width), _screen_side_y);
	}
} else
	draw_sprite_ext(spr_index, img_index + img_index_offset, x, y, img_xscale, img_yscale, img_angle, img_color, img_alpha);