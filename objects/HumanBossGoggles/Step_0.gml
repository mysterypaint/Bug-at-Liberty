/// @description State Machine; Kill if <0 HP
/*
if (hp <= 0 && hp > -99999)
	instance_destroy();
*/
switch (state) {
	case EnemyStates.UNLOADED:
		state = EnemyStates.IDLE;
		can_hurt_player = true;
		break;
	case EnemyStates.IDLE:
		if (hp < 0 && hp > -99999) {
			switch(current_tier) {
				case 1:
					current_tier++;
					hp = tier_2_hp;
					parent_id.next_attack_timer_reset = 350;
					parent_id.wait_timer_reset = 150;
					img_index = 1;
					sfx_play(sfxBossGemBreak);
					break;
				case 2:
					current_tier++;
					hp = tier_3_hp;
					img_index = 2;
					parent_id.next_attack_timer_reset = 250;
					parent_id.wait_timer_reset = 125;
					sfx_play(sfxBossGemBreak);
					break;
				case 3:
					instance_destroy();
					break;
			}
		}
		break;
	case EnemyStates.MOVING:
		break;
	case EnemyStates.ATTACKING:
		break;
	case EnemyStates.DYING:
		break;
}

// De-spawn if too far away from the camera
//despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;