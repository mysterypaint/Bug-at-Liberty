/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (white_flash_timer > 0) {
	draw_set_color(c_white);
	draw_set_alpha(0.6);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);
	draw_set_alpha(1);
	white_flash_timer -= Game.dt;
}