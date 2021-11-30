/// @description Insert description here
if (wait_timer > 0) {
	var _spr_warning_width = 7;
	var _spr_warning_height = 20;
	var _screen_side_x = Camera.x;
	
	if (moving_left)
		_screen_side_x = Camera.x + Game.base_res_width - _spr_warning_width;
	
	for (var _i = 0; _i < 5; _i++) {
		draw_sprite(sprWarning, caution_img_index, _screen_side_x, y - (2 * _spr_warning_height) + (_i * _spr_warning_height));
	}
} else
	draw_sprite_ext(spr_index, img_index + img_index_offset, x, y, img_xscale, img_yscale, img_angle, img_color, img_alpha);