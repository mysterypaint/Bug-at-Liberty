/// @description Insert description here
//draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(Game.spr_font);

var _ts = Game.TILE_SIZE;
var _hts = _ts / 2;

switch(Game.state) {
	case GameStates.TITLE:
		draw_text(15 * _hts, 1 * _hts, "\n\nBug Shmup");
		if (Game.tick % Game.TITLE_BLINK_SPEED == 0)
			Game.show_titlescreen_prompt = !Game.show_titlescreen_prompt;
		
		draw_set_color(c_yellow);
		if (Game.show_titlescreen_prompt)
			draw_text(13 * _hts, 7 * _hts, "- Press Confirm -");
		
		draw_set_color(c_white);
		draw_text(0 * _hts, 10 * _hts, "- Controls -\nWASD/Arrow Keys - Move the Ship\nZ/J - Shoot Bullets, Menu Cancel\nC/L - Cycle through Bug Fighters (Tentative)\nEnter/H - Pause, Menu Confirm\n\nF7 - Window Size\nF4 (or Alt+Enter) - Toggle Fullscreen");
		break;
	case GameStates.PAUSED:
	case GameStates.GAMEPLAY:
	
		var i = 0;
		
		
		if (ds_exists(LevelData.layers, ds_type_list)) {
			var _layers_size = ds_list_size(LevelData.layers);
	
			for (var _i = 0; _i < _layers_size; _i++) {
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
		
		draw_set_color(c_white);
		
		
		// Draw entities
		
		/*
		with (Wall) {
			draw_self();
		}*/

		// Draw all of the Draw objects in order, by their depth
		var _dgrid = ds_draw_object_depth_sort;
		var _num_draw_objects = instance_number(ParentDraw);
		
		ds_grid_resize(_dgrid, 2, _num_draw_objects);
		
		var _yy = 0; with (ParentDraw) {
			_dgrid[# 0, _yy] = id;
			_dgrid[# 1, _yy] = depth;
			_yy++;
		}
		
		ds_grid_sort(_dgrid, 1, true);
		
		var _inst;
		
		_yy = 0; repeat (_num_draw_objects) {
			// pull out an ID
			_inst = _dgrid[# 0, _yy];
			// get instance to draw itself
			with (_inst) {
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
		
		// Weapon boxes & Cursor
		var _len = BulletTypes.MAX;
		for (var _i = 0; _i < _len; _i++) {
			draw_sprite(sprHUDWeaponBox, 0, x + (_i * weapon_box_width) + weapon_hud_xoff, y + weapon_hud_yoff);
			draw_sprite(sprHUDWeapons, _i, x + (_i * weapon_box_width) + weapon_hud_xoff, y + weapon_hud_yoff);
			
			if (_i == Ship.bullet_type)
				draw_sprite(sprHUDWeaponCursor, _i, x + (_i * weapon_box_width) + weapon_hud_xoff + 1, y + weapon_hud_yoff + 1);
		}
		
		draw_text(x + 131, y + 7, "Score: 0");//69696969nicenincieninciencinei");
		
		// Num Lives
		
		var _lives = Game.player_lives - 1;
		
		for (var _i = 0; _i < _lives; _i++) {
			draw_sprite(sprLife, 0, x + (_i * weapon_box_width) + lives_hud_xoff, y + lives_hud_yoff);
		}
		
		//draw_text(x, y, "Bullet Type: " + get_bullet_type_name());
		
		
		draw_set_alpha(1);
		if (Game.state == GameStates.PAUSED) {
			
			if (Game.tick % Game.GAME_PAUSED_TEXT_BLINK_SPEED == 0)
				Game.show_pause_text = !Game.show_pause_text;
		
		
			if (Game.show_pause_text) {
				draw_text(Camera.x + 15 * _hts, Camera.y + 10 * _hts, "- Game Paused -");
			}
		}
		break;
	
}

