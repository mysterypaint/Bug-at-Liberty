// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function kill_player() {
	if (instance_exists(EnemyHumanBossFace)) {
		if (EnemyHumanBossFace.hp <= -99999 && EnemyHumanBossFace.state == EnemyStates.DYING)
			return; // Do not allow the player to die after they've killed the endgame boss.
	}
	
	if (!dead && !Game.debug) {
		if (inv_frames_timer <= 0 || curr_hp <= 0) {
			if (curr_hp <= 0) {
				dead = true;
				death_timer = death_timer_reset;
		
				//audio_stop_sound(Game.curr_bgm);
		
				instance_create_depth(x + 8, y + 13, depth + 1, PlayerExplosion);
				sfx_play(sfxPlayerExplosion);
	
				with (Camera) {
					if (!instance_exists(EnemyHumanBossFace)) {
						prev_move_x = move_x;
						prev_move_y = move_y;
						move_x = 0.2;
						move_y = 0;
					} else {
						prev_move_x = 0.4;
						prev_move_y = 0;
						move_x = 0.4;
						move_y = 0;
					}
				}
			} else {
				curr_hp--;
				inv_frames_timer = inv_frames_timer_reset;
			}
		} else {
			inv_frames_timer -= Game.dt;
		}
	}
}