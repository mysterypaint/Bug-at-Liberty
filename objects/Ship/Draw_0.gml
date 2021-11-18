/// @description Insert description here
draw_sprite(sprite_index, img_index_offset + img_index, x + 7, y + 6);

img_index = (img_index + (img_speed * Game.dt)) % img_ani_frames_max;

if (Game.debug) {
	var _col = c_red;
	draw_rectangle_color(bbox_left + 1, bbox_top + 1, bbox_right - 1, bbox_bottom - 1, _col, _col, _col, _col, true);
}