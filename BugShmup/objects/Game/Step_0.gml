/// @description Insert description here
switch(state) {
	case GameStates.INIT:
		state = GameStates.TITLE;
		break;
	case GameStates.TITLE:
		if (key_pause_pressed) {
			playerShip = instance_create_depth(0, 0, 0, Ship);
			//room_goto(rm_lv1);
			level_data_obj = read_json("testmap0.json");
			
			state = GameStates.GAMEPLAY;
			pause_timer = pause_timer_reset;
		}
		break;
	case GameStates.GAMEPLAY:
		if (key_pause_pressed && pause_timer <= 0) {
			dt = 0;
			prev_state = GameStates.GAMEPLAY;
			state = GameStates.PAUSED;
			pause_timer = pause_timer_reset;
		}
		
		if (keyboard_check_pressed(ord("T"))) {
			if (!instance_exists(Textbox))
				var _tbox = create_textbox(0);
		}
		player_score += (1 * dt);
		break;
	case GameStates.PAUSED:
		if (key_pause_pressed && pause_timer <= 0) {
			dt = 1;
			state = prev_state;
			prev_state = GameStates.PAUSED;
			
			pause_timer = pause_timer_reset;
		}
		break;	
}

// Toggle fullscreen with F4/Alt+Enter
if (keyboard_check_pressed(vk_f4) || (keyboard_check(vk_alt) && keyboard_check_pressed(vk_enter))) {
	window_set_fullscreen(!window_get_fullscreen());
}

if (keyboard_check_pressed(vk_f7)) {
	zoom_size++;
	if (zoom_size > zoom_size_max)
		zoom_size = 1;
	
	window_set_size(base_res_width * zoom_size, base_res_height * zoom_size);
	alarm[0] = 1;
}

if (pause_timer > 0)
	pause_timer--;

tick++;