// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sfx_play(_id, _priority = 0, _loops = false) {
	audio_stop_sound(_id);
	audio_play_sound(_id, _priority, _loops);
}