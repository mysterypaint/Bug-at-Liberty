/// @description Insert description here
if (other.object_index == BulletFireflyExplosion) {
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
		//show_debug_message("Enemy hurt by " + string(other.atk_stat) + " points. HP left: " + string(hp));
	}
}

if (other.object_index == BulletFireflyExplosion) {
	ds_list_add(other.hurt_enemies, id);
}

with (other)
	instance_destroy();