// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bgm_play(_bgm, _priority, _loops, _intro_length, _total_length){
	with (Game) {
		curr_bgm = audio_play_sound(_bgm, _priority, _loops);
		if (_loops) {
			bgm_intro_length = _intro_length;
			bgm_total_length = _total_length;
			bgm_loop_length = bgm_total_length - bgm_intro_length;
		} else {
			bgm_intro_length = -1;
			bgm_loop_length = -1;
			bgm_total_length = -1;
		}
	}
}