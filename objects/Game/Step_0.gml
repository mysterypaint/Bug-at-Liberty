/// @description Insert description here
switch(state) {
	case GameStates.VICTORY_SCREEN:
		if (victory_screen_timer > 0) {
			Camera.screenshake = 0;
			Camera.screenshake_xoff = 0;
			Camera.screenshake_yoff = 0;
			victory_screen_timer -= Game.dt;
		} else {
			state = GameStates.CREDITS;
		}
		break;
	case GameStates.CREDITS:
		if (game_end_timer > 0)
			game_end_timer -= Game.dt;
		else if (key_pause_pressed)
			game_restart();
		break;
	case GameStates.INIT:
		state = GameStates.TITLE;
		audio_group_set_gain(AudioGroupSFX, 1, 1); // SFX
		audio_group_set_gain(AudioGroupBGM, 0.8, 1); // BGM
		audio_group_load(AudioGroupSFX);
		audio_group_load(AudioGroupBGM);
		break;
	case GameStates.TITLE:
		if (key_pause_pressed && !title_screen_show_controls && begin_game_timer == -1) {
			begin_game_timer = begin_game_timer_reset;
			TITLE_BLINK_SPEED = 4;
			sfx_play(sfxTitleScreenConfirm);
		}
		
		if (begin_game_timer <= -1) {
			if (key_weapon_change_forward_pressed)
				game_difficulty++
		
			if (game_difficulty > GameDifficulties.MAX - 1)
				game_difficulty = 0;
		}
		
		if (begin_game_timer > 0) {
			begin_game_timer -= Game.dt;
		} else if (begin_game_timer == 0) {
			playerShip = instance_create_depth(64 + 32, 32*2, 0, Ship);
			
			switch(game_difficulty) {
				case GameDifficulties.REGULAR:
					playerShip.max_hp = 6;
					playerShip.curr_hp = playerShip.max_hp;
					reset_helpers_on_death = false;
					obtain_caged_helpers = true;
					break;
				case GameDifficulties.ARCADE:
					playerShip.max_hp = -1;
					playerShip.curr_hp = -1;
					player_lives = 5;
					reset_helpers_on_death = true;
					obtain_caged_helpers = true;
					break;
				case GameDifficulties.NIGHTMARE:
					playerShip.max_hp = -1;
					playerShip.curr_hp = -1;
					player_lives = 3;
					reset_helpers_on_death = true;
					obtain_caged_helpers = false;
					break;
			}
			//room_goto(rm_lv1);
			level_data_obj = read_json("level.json");
			
			state = GameStates.GAMEPLAY;
			pause_timer = pause_timer_reset;
			
			bgm_play(musMainLevel, 0, true, 6.109, 128.899);
			
			begin_game_timer = -1;
		}
		break;
	case GameStates.FADE_TO_VICTORY_SCREEN:
		if (Game.tick % 5 == 0) {
			if (!stop_endgame_explosions) {
				var _x = Camera.x + irandom_range(0, Game.base_res_width);
				var _y = Camera.y + irandom_range(0, Game.base_res_height);
				instance_create_depth(_x, _y, depth, EnemyExplosion);
				sfx_play(sfxGenericEnemyExplosion);
			}
		}
	case GameStates.GAMEPLAY:
		if (Game.player_lives <= 0) {
			TITLE_BLINK_SPEED = 30;
			state = GameStates.GAMEOVER;
			bgm_stop();
			audio_stop_all();
			bgm_play(musGameOverJingle, 0, false, 500, 99999);
			break;
		}
	
		if (key_pause_pressed && pause_timer <= 0) {
			if (!playerShip.dead) { // Allow pausing, but only if the player isn't dead
				dt = 0;
				prev_state = GameStates.GAMEPLAY;
				state = GameStates.PAUSED;
				sfx_play(sfxPause);
				pause_timer = pause_timer_reset;
				
				bgm_pause(curr_bgm);
			}
		}
		
		/*
		if (keyboard_check_pressed(ord("T"))) {
			if (!instance_exists(Textbox))
				var _tbox = create_textbox(0);
		}*/
		//player_score += (1 * dt);
		break;
	case GameStates.PAUSED:
		if (key_pause_pressed && pause_timer <= 0) {
			dt = 1;
			state = prev_state;
			prev_state = GameStates.PAUSED;
			pause_timer = pause_timer_reset;
			sfx_play(sfxUnPause);
			bgm_resume(curr_bgm);
		}
		break;
	case GameStates.GAMEOVER:
		with (Camera) {
			move_x = 0;
			move_y = 0;
			x = 0;
			y = 0;
			camera_set_view_pos(view_camera[0], x + screenshake_xoff, y + screenshake_yoff);
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