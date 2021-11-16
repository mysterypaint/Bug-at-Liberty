/// @description Insert description here
if ((proceed_timer >= next_proceed_value) && tbox_timer <= 0) {
	
	var _text_size = ds_grid_height(Game.text_contents);
	if (tbox_position + tbox_position >= _text_size)
		instance_destroy();
	else {
		tbox_position++;
		
		curr_port = Game.text_contents[# 0, tbox_position];
		curr_name = Game.text_contents[# 1, tbox_position];
		curr_text = Game.text_contents[# 2, tbox_position];
		next_proceed_value = Game.text_contents[# 3, tbox_position];
		proceed_timer = 0;
		
		tbox_timer = tbox_timer_reset;
	}
}

if (tbox_timer > 0)
	tbox_timer -= 1 * Game.dt;

time_alive += 1 * Game.dt;
proceed_timer += 1 * Game.dt;