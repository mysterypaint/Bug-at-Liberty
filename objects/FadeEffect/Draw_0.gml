/// @description Insert description here
a = clamp(a + (fade * 0.05), 0, 1);

if (a == 1) {
	switch (transition_type) {
		case TransitionTypes.LEVEL_RESET: // Reset the level; subtract a life from the player
			with (parent_id) {
				// Reset the room
				Game.player_lives--;
				if (Game.player_lives > 0) {
					dead = false;
					draw_me = true;
					init_player = init_player_reset;
					curr_hp = max_hp;
				
					respawn_room_entities();
					//audio_play_sound(Game.curr_bgm, 0, true);
					Camera.checkpoint_display_timer = 0;
					x = Game.checkpoint + 120;
					y = 32;
					
					// Reset all player's previous position arrays back to the player's (x, y)
					for (var _i = 29; _i >= 0; _i--) {
						player_ghost_x[_i] = x;
						player_ghost_y[_i] = y;
					}
					
					if (Game.reset_helpers_on_death) {
						// Remove all of the player's helpers
					
						for (var _i = 2; _i >= 0; _i--) {
							var _this_helper = helpers[_i];
							_this_helper.activated = false;
							_this_helper.draw_me = false;
						}
						helpers_activated = -1;	
					} else {
						// Update all the helpers' positions
						for (var _i = 2; _i >= 0; _i--) {
							var _this_helper = helpers[_i];
							_this_helper.x = player_ghost_x[_i * 10 + 9];
							_this_helper.y = player_ghost_y[_i * 10 + 9];
						}
					}
				}
				
			}
			
			
			with (Camera) {
				if (Game.player_lives >= 0) {
					x = Game.checkpoint;
					y = 0;
					move_x = prev_move_x;
					move_y = prev_move_y;
				} else {
					x = 0;
					y = 0;
					move_x = 0;
					move_y = 0;
				}
				camera_set_view_pos(view_camera[0], Camera.x, Camera.y);
			}
			break;
	}
	fade = -1;
} else if ((a == 0) && (fade == -1)) {
	instance_destroy();
}

draw_set_color(c_black);
draw_set_alpha(a);

var _brw = Game.base_res_width;
var _brh = Game.base_res_height;
var _padding = _brw;
var _x = Camera.x;
var _y = Camera.y;
draw_rectangle(_x - _padding, _y - _padding, _x + _brw + _padding, _y + _brh + _padding, false);

_x = camera_get_view_x(view_camera[0]);
_y = camera_get_view_y(view_camera[0]);
draw_rectangle(_x - _padding, _y - _padding, _x + _brw + _padding, _y + _brh + _padding, false);

draw_set_alpha(1);