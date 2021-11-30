/// @description Insert description here
//draw_set_halign(fa_center);

if (hide_camera)
	exit;

draw_set_color(c_white);
draw_set_font(Game.spr_font);

var _ts = Game.TILE_SIZE;
var _hts = _ts / 2;

switch(Game.state) {
	case GameStates.TITLE:
		if (!Game.title_screen_show_controls) {
			draw_sprite(sprTitleScreen, 0, 0, 0);
			draw_text(17 * _hts, 1 * _hts, "\n\nBug Shmup");
			if (Game.tick % Game.TITLE_BLINK_SPEED == 0)
				Game.show_titlescreen_prompt = !Game.show_titlescreen_prompt;
		
			draw_set_color(c_yellow);
			if (Game.show_titlescreen_prompt)
				draw_text(11 * _hts, 7 * _hts, "- Press Pause to begin -");
			
			draw_set_color(c_dkgray);
			draw_text(0 * _hts, 11 * _hts, "- Press X to view game controls -");
			draw_text(0 * _hts, 12 * _hts, "Game difficulty: " + print_game_difficulty(Game.game_difficulty) + " (Press C/L to change)");
			if (keyboard_check_pressed(ord("X")))
				Game.title_screen_show_controls = true;
		} else {
			if (Game.key_confirm_pressed || Game.key_cancel_pressed)
				Game.title_screen_show_controls = false;
			draw_set_color(c_black);
			draw_rectangle(0, 0, Game.base_res_width, Game.base_res_height, false);
			var _controls = "- Controls -\nWASD/Arrow Keys - Move the Ship\nZ/J - Shoot Bullets, Menu Cancel\nX/K, C/L - Cycle through weapons\nX/K - Menu Confirm\nEnter/H - Pause\n\nF7 - Window Size\nF4 (or Alt+Enter) - Toggle Fullscreen\n\n\nPress 'Menu Confirm' or 'Menu Cancel' to return.";
			draw_set_color(c_dkgray);
			draw_text(0 * _hts + 1, 0 * _hts + 1, _controls);
			
			draw_set_color(c_white);
			draw_text(0 * _hts, 0 * _hts, _controls);
		}
		break;
	case GameStates.GAMEOVER:
		//draw_set_color(c_white);
		//draw_text(0, 0, "gmae over lol\n\nu fukken died!");
		draw_sprite(sprGameOverScreen, 0, 0, 0);
		
		if (Game.tick % Game.TITLE_BLINK_SPEED == 0)
			Game.show_titlescreen_prompt = !Game.show_titlescreen_prompt;

		if (Game.show_titlescreen_prompt) {
			draw_set_color(c_orange);
			var _str = "Press Pause to return to the Title Screen";
			draw_text(6 * _hts + 1, 13 * _hts + 1, _str);
			draw_set_color(c_yellow);
			draw_text(6 * _hts, 13 * _hts, _str);
		}
		if (instance_exists(FadeEffect)) {
			with (FadeEffect) {
				event_perform(ev_draw, 0);
			}
		}
		break;
	case GameStates.PAUSED:
	case GameStates.GAMEPLAY:
		var i = 0;
		
		if (instance_exists(LevelData)) {
			if (ds_exists(LevelData.layers, ds_type_list)) {
				var _layers_size = ds_list_size(LevelData.layers);
	
				for (var _i = 0; _i < _layers_size; _i++) {
					if (_i == LevelData.shadow_layer) {
						draw_set_alpha(shadow_layer_alpha);
						var _col = c_black;
						draw_rectangle_color(x-Game.TILE_SIZE, y- Game.TILE_SIZE, x + Game.base_res_width + Game.TILE_SIZE, y + Game.base_res_height + Game.TILE_SIZE, _col, _col, _col, _col, false);
						draw_set_alpha(1);
					}
					
					
					var _this_layer = LevelData.layers[| _i];
					var _this_layer_name = _this_layer[| 0];
		
					if (_this_layer_name != "Instances") {
						var _is_collision_layer = false;
						if (_this_layer_name == "Collision")
							_is_collision_layer = true;
						var _lvl_data_grid = _this_layer[| 1];
					
						draw_level_data(_lvl_data_grid, _is_collision_layer);
					}
				}
			}
		}
		
		draw_set_color(c_white);
		
		// Draw entities

		// Draw all of the Draw objects in order, by their depth		
		var _inst;
		
		var _yy = 0; repeat (num_draw_objects) {
			// pull out an ID
			_inst = ds_draw_object_depth_sort[# 0, _yy];
			// get instance to draw itself
			with (_inst) {
				if (draw_me)
					event_perform(ev_draw, 0);
			}
			_yy++;
		}
		
		// Draw the textbox
		
		if (instance_exists(Textbox)) {
			with(Textbox) {
				event_perform(ev_draw, 0);
			}
		}
		
		
		// Draw the game HUD
		draw_set_alpha(hud_alpha);
		draw_sprite(sprHUDHealth, 0, x + hp_hud_xoff, y + hp_hud_yoff);
		var _max_hp = Ship.max_hp;
		if (_max_hp > 0) {
			var _hp_left = Ship.curr_hp;
			for (var _i = 0; _i < _max_hp; _i++) {
				if (_hp_left > 0)
					draw_sprite(sprHUDHealth, 2, x + hp_hud_xoff + 6 + hp_hud_width + (_i * hp_hud_width), y + hp_hud_yoff);
				else
					draw_sprite(sprHUDHealth, 1, x + hp_hud_xoff + 7 + hp_hud_width + (_i * hp_hud_width), y + hp_hud_yoff);
				_hp_left--;
			}
		} else {
			hud_sleeping_img_index += hud_sleeping_img_speed;
			if (hud_sleeping_img_index >= 2)
				hud_sleeping_img_index = 0;
			draw_sprite(sprSleeping, hud_sleeping_img_index % 2, x + hp_hud_xoff + 7 + hp_hud_width, y + hp_hud_yoff);
		}
		
		// Weapon boxes & Cursor
		var _len = Fighters.MAX;
		for (var _i = 0; _i < _len; _i++) {
			draw_sprite(sprHUDWeaponBox, 0, x + (_i * weapon_box_width) + weapon_hud_xoff, y + weapon_hud_yoff);
			var _weapon_enabled = Game.enabled_weapons[_i];
			draw_sprite(sprHUDWeapons, (_i * 2) + _weapon_enabled, x + (_i * weapon_box_width) + weapon_hud_xoff, y + weapon_hud_yoff);
			
			if (_i == Ship.bullet_type) {
				draw_set_alpha(1);
				draw_sprite(sprHUDWeaponCursor, _i, x + (_i * weapon_box_width) + weapon_hud_xoff + 1, y + weapon_hud_yoff + 1);
				draw_set_alpha(hud_alpha);
			}
		}
		
		//draw_text(x + 131, y + 7, "Score: 0");
		
		// Num Lives
		
		var _lives = Game.player_lives;
		
		for (var _i = 0; _i < _lives - 1; _i++) {
			draw_sprite(sprHUDLife, 0, x + (_i * weapon_box_width) + lives_hud_xoff, y + lives_hud_yoff);
		}
		
		//draw_text(x, y, "Bullet Type: " + get_bullet_type_name());
		
		with (ParentEnemyBullet) {
			event_perform(ev_draw, 0);
		}
		
		
		draw_set_alpha(1);
		
		//var _tx = floor(Ship.x / Game.TILE_SIZE);
		//var _ty = floor(Ship.y / Game.TILE_SIZE);
		//draw_text(Camera.x, Camera.y, string(_tx) + ", " + string(_ty));		
		if (Game.state == GameStates.PAUSED) {
			
			if (Game.tick % Game.GAME_PAUSED_TEXT_BLINK_SPEED == 0)
				Game.show_pause_text = !Game.show_pause_text;
		
		
			if (Game.show_pause_text) {
				draw_text(Camera.x + 15 * _hts, Camera.y + 10 * _hts, "- Game Paused -");
			}
		}
		
		if (checkpoint_display_timer > 0) {
			if (checkpoint_display_timer % checkpoint_display_blink_rate == 0)
				checkpoint_display_visible = !checkpoint_display_visible;
			
			if (checkpoint_display_visible) {
				draw_set_color(c_yellow);
				draw_text(x + (8*24), y + (8*21), "Checkpoint reached!");
				draw_set_color(c_white);
			}
			checkpoint_display_timer -= Game.dt;
		}
		
		if (instance_exists(ParentVFX)) {
			with (ParentVFX) {
				event_perform(ev_draw, 0);
			}
		}
		
		if (instance_exists(FadeEffect)) {
			with (FadeEffect) {
				event_perform(ev_draw, 0);
			}
		}
		break;
	
}


if (Game.debug) {
	draw_set_color(c_white);
	draw_text(x + Game.base_res_width - (8 * 8), y, "fps: " + string(fps));
	if (Game.mute_bgm) {
		draw_set_color(c_red);
		draw_text(x + Game.base_res_width - (8 * 8), y + 8, "BGM MUTED");
		draw_set_color(c_white);
	}
}