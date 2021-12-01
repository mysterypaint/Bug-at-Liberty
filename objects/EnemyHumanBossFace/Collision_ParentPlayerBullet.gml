/// @description Insert description here
if (other.object_index == ParentPlayerWeaponExplosion) {
	var _ffexplosion = other;
	var _already_hurt = false;
	var _enemies_hurt = ds_list_size(_ffexplosion.hurt_enemies);
	
	for (var _i = 0; _i < _enemies_hurt; _i++) {
		var _this_enemy = _enemies_hurt[| _i];
		if (_this_enemy == id)
			_already_hurt = true;
	}
	
	if (_already_hurt)
		exit;
}

if (state != EnemyStates.UNLOADED) {
	if (hp > -99999) {
		hp -= other.atk_stat;
		if (hp > 0)
			sfx_play(sfxGenericEnemyDamaged);
		
		//show_debug_message("Enemy hurt by " + string(other.atk_stat) + " points. HP left: " + string(hp));
	} else {
		sfx_play(sfxGenericEnemyBlockBullet);
		
		if (state == EnemyStates.IDLE && sneeze_cooldown_timer <= 0) {
			if (other.y > HumanBossGoggles.bbox_bottom) {
				spr_index = sprHumanBossSneeze;
				ani_max_frames = sprite_get_number(spr_index);
				img_index = 0;
				img_speed = 0.2;
				sfx_play(sfxBossSneeze);
				state = EnemyStates.ATTACKING; // sneeze mode
				
			}
		}
	}
}

if (other.object_index == ParentPlayerWeaponExplosion) {
	ds_list_add(other.hurt_enemies, id);
}

with (other)
	instance_destroy();