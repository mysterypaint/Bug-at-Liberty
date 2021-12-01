/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999) {
	state = EnemyStates.DYING;
	
	hp = -99999;
	
	
	Camera.screenshake = 300;
	Camera.alarm[0] = 820; // Actual transition
	Camera.alarm[1] = 600; // Fadeout trigger
	Camera.alarm[2] = 300; // Stop explosions
	Game.state = GameStates.FADE_TO_VICTORY_SCREEN;
	bgm_stop();
}

if (Camera.screenshake <= 0 && state == EnemyStates.DYING && !defeat_animation_started) {
	spr_index = sprHumanBossDefeat;
	sprite_index = spr_index;
	img_speed = 0.2;
	ani_max_frames = sprite_get_number(sprHumanBossDefeat);
	img_index = 0;
	defeat_animation_started = true;
}

switch (state) {
	case EnemyStates.UNLOADED:
		can_hurt_player = true;
		if (Camera.move_x != 0)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			my_goggles.hp = my_goggles.tier_1_hp;
		}
		break;
	case EnemyStates.ATTACKING:
		// Sneezing phase
		if (img_index >= ani_max_frames) {
			state = EnemyStates.IDLE;
			next_attack_timer = irandom(next_attack_timer_reset);
			spr_index = sprHumanBossSneeze;
			ani_max_frames = sprite_get_number(spr_index);
			img_speed = 0;
			img_index = 0;
			sneeze_cooldown_timer = sneeze_cooldown_timer_reset;
		} else if (img_index == 10) {
			var _num_sneeze_bullets = 20;
			for (var _i = 0; _i < _num_sneeze_bullets; _i++) {
				var _bullet_type = choose(EnemyBulletTypes.SNEEZE, EnemyBulletTypes.SNEEZE, EnemyBulletTypes.LARGE);
				shoot_at_player(_bullet_type);
			}
		}
	case EnemyStates.IDLE:
		// Regardless we are idle or sneezing, spawn a bunch of hands to swat the player
		if (Game.tick % next_attack_timer == 0 && Game.dt > 0) {
			var _num_hands = instance_number(EnemyHandParent);
			if (_num_hands <= 3) {
				next_attack_timer = irandom_range(1, next_attack_timer_reset);
				var _name = choose("EnemyHandHorizontal",
				"EnemyHandVertical",
				"EnemyHandSingleHorizontal",
				"EnemyHandSingleVertical",
				"EnemyHand"
				);
				var _is_foot = choose(true, false);
				var _wait_timer = wait_timer_reset;//irandom_range(0, 200);
				boss_spawn_hand(_name, _is_foot, _wait_timer);
			}
		}
		break;
	case EnemyStates.DYING:
		if (img_index >= ani_max_frames - 1) {
			img_index = ani_max_frames - 1;
			img_speed = 0;
		} else if (img_index == 1) {
			if (!eye_shatter_sfx_played) {
				sfx_play(sfxBossGemBreak);
				eye_shatter_sfx_played = true;
			}
		}
		
		
		break;
}

// De-spawn if too far away from the camera
//despawn_if_oob();

if (sneeze_cooldown_timer > 0)
	sneeze_cooldown_timer -= Game.dt;

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;