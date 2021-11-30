// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bgm_stop(_bgm) {
	if (curr_bgm >= 0)
		audio_stop_sound(_bgm);
}