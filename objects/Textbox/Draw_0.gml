/// @description Insert description here
draw_set_alpha(tbox_alpha);
draw_sprite(sprTextboxMain, 0, x + base_x, y + base_y);
draw_set_alpha(nametag_box_alpha);
draw_sprite(sprTextboxNametagWindow, 0, x + base_x + nametag_box_x, y + base_y + nametag_box_y);
draw_set_alpha(text_alpha);
draw_text(x + base_x + nametag_box_x + 3, y + base_y + nametag_box_y + 2, curr_name);



var _xoff = text_padding_x;

if (curr_port >= 0) {
	_xoff += 60;
	
	draw_set_alpha(portrait_box_alpha);
	draw_sprite(sprTextboxPortraitWindow, 0, x + base_x + portrait_box_x, y + base_y + portrait_box_y);
	draw_set_alpha(portrait_alpha);
	draw_sprite(sprTextboxPortraits, curr_port, x + base_x + portrait_box_x + 1, y + base_y + portrait_box_y + 1);
}

draw_text(x + base_x + _xoff, y + base_y + text_padding_y, curr_text);

draw_set_alpha(1);