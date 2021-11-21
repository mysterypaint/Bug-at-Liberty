// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function kill_player() {
	if (!dead && !Game.debug) {
		dead = true;
		death_timer = death_timer_reset;
		
		//audio_stop_sound(Game.curr_bgm);
		
		instance_create_depth(x + 8, y + 13, depth + 1, PlayerExplosion);
	
		with (Camera) {
			prev_move_x = move_x;
			prev_move_y = move_y;
			move_x = 0.2;
			move_y = 0;
		}
	}
}