/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			audio_group_set_gain(AudioGroupBGM, 0, 5000); // Fade out the BGM
			var _boss = instance_create_depth(x + 49 + (16 * 9), y - (16 * 5), depth, EnemyHumanBossFace);
			ds_list_add(Game.level_data_obj.instances, _boss);
			boss_begin_timer = boss_begin_timer_reset;
			state = EnemyStates.IDLE;
		}
		break;
	case EnemyStates.IDLE:
		if (boss_begin_timer > 0) {
			boss_begin_timer -= Game.dt;
		} else {
			bgm_stop()
			bgm_play(musHumanBoss, 0, true, 5.627, 137.627);
			Camera.scroll_to_boss = true; // Stop the camera scrolling at the boss
			state = EnemyStates.DYING;
		}
		break;
	case EnemyStates.DYING:
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;