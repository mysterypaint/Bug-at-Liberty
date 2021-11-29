// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bgm_step(_bgm) {
	with (Game) {
		if (curr_bgm > 0) {
			/*
			var _pos;
			
			if (keyboard_check_pressed(ord("U"))) {
				audio_sound_set_track_position(curr_bgm, bgm_total_length - 10);
				_pos = audio_sound_get_track_position(curr_bgm);
				
			}*/
			var _pos = audio_sound_get_track_position(curr_bgm);
			//show_debug_message(string(_pos) + "/" + string(bgm_total_length) )
			if (_pos > bgm_total_length) {
				audio_sound_set_track_position(curr_bgm, _pos - bgm_loop_length);
				//show_debug_message("looping: " + string(_pos - bgm_loop_length));
			}
		}
	}
}