/// @description Insert description here
switch(state) {
	case GameStates.INIT:
		state = GameStates.TITLE;
		audio_group_set_gain(audiogroup1, 1, 1); // SFX
		audio_group_set_gain(audiogroup2, 0.8, 1); // BGM
		audio_group_load(audiogroup1);
		audio_group_load(audiogroup2);
		break;
	case GameStates.TITLE:
		if (key_pause_pressed && !title_screen_show_controls) {
			playerShip = instance_create_depth(120, 32, 0, Ship);
			//room_goto(rm_lv1);
			level_data_obj = read_json("testmap0.json");
			
			state = GameStates.GAMEPLAY;
			pause_timer = pause_timer_reset;
			
			curr_bgm = musMainLevel;
			bgm_play(curr_bgm, 0, true, 6.109, 128.899);
		}
		break;
	case GameStates.GAMEPLAY:
		if (Game.player_lives <= 0) {
			state = GameStates.GAMEOVER;
			bgm_stop(curr_bgm);
			break;
		}
	
		if (key_pause_pressed && pause_timer <= 0) {
			if (!playerShip.dead) { // Allow pausing, but only if the player isn't dead
				dt = 0;
				prev_state = GameStates.GAMEPLAY;
				state = GameStates.PAUSED;
				pause_timer = pause_timer_reset;
				
				bgm_pause(curr_bgm);
			}
		}
		
		if (keyboard_check_pressed(ord("T"))) {
			if (!instance_exists(Textbox))
				var _tbox = create_textbox(0);
		}
		//player_score += (1 * dt);
		break;
	case GameStates.PAUSED:
		if (key_pause_pressed && pause_timer <= 0) {
			dt = 1;
			state = prev_state;
			prev_state = GameStates.PAUSED;
			pause_timer = pause_timer_reset;
			
			bgm_resume(curr_bgm);
		}
		break;
	case GameStates.GAMEOVER:
		with (Camera) {
			move_x = 0;
			move_y = 0;
			x = 0;
			y = 0;
			camera_set_view_pos(view_camera[0], x, y);
		}
		
		if (key_pause_pressed)
			game_restart();
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