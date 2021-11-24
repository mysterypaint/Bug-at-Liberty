/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			can_hurt_player = true;
		}
		break;
	case EnemyStates.IDLE:
		if (cast_timer <= 0) {
			cast_timer = cast_timer_reset;
			curr_spell = choose(MantisSpells.ELECTRIC, MantisSpells.WIND);
			spell_duration_timer = spell_durations[curr_spell];
			
			sprite_index = casting_sprites[curr_spell];
			spr_index = sprite_index;
			ani_max_frames = sprite_get_number(spr_index);
			
			state = EnemyStates.ATTACKING;
			
			switch(curr_spell) {
				default:
				case MantisSpells.ELECTRIC:
					instance_create_depth(Ship.x, Camera.y, depth, EnemyLightning)
					break;
				case MantisSpells.WIND:
					var _fans = instance_create_depth(Ship.x, Camera.y, depth, EnemyOverlayFan)
					_fans.duration = spell_durations[MantisSpells.WIND];
					break;
			}
		} else {
			cast_timer -= Game.dt;
		}
		break;
	case EnemyStates.ATTACKING:
		if (spell_duration_timer <= 0) {
			state = EnemyStates.IDLE;
			img_index = 0;
			img_speed = 0.2;
			
			sprite_index = casting_sprites[MantisSpells.NONE];
			spr_index = sprite_index;
			ani_max_frames = sprite_get_number(spr_index);

		} else if (spell_duration_timer <= 4) {
			img_index = ani_max_frames - 1;
			img_speed = 0;
			spell_duration_timer -= Game.dt;
		} else {
			if (img_index >= ani_max_frames - 1)
				img_index = 2;
			spell_duration_timer -= Game.dt;
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