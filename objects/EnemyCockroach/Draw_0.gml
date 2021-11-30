/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
if (Game.debug) {
	draw_set_alpha(0.4);
	draw_rectangle(
	x - spr_flying_x_origin,
				y - spr_flying_y_origin,
				x + spr_flying_x_origin,
				y + spr_flying_x_origin,
				false);
	draw_set_alpha(1);
}