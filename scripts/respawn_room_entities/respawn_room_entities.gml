// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function respawn_room_entities(){
	var _lvl_obj = Game.level_data_obj;
	
	// First, delete all the existing entities within the room
	
	if (instance_exists(PilotBug))
		instance_destroy(PilotBug);
	if (instance_exists(Textbox))
		instance_destroy(Textbox);
	if (instance_exists(ParentEnemyBullet))
		instance_destroy(ParentEnemyBullet);
	if (instance_exists(ParentPlayerBullet))
		instance_destroy(ParentPlayerBullet);
	if (instance_exists(PlayerPowerup))
		instance_destroy(PlayerPowerup);
	if (instance_exists(EnemyExplosion)) {
		with (EnemyExplosion) {
			silent_death = true;
			instance_destroy();
		}
	}
		instance_destroy(EnemyExplosion);
	if (instance_exists(PlayerExplosion))
		instance_destroy(PlayerExplosion);
	if (instance_exists(EnemyLightning)) {
		with (EnemyLightning) {
			silent_death = true;
			instance_destroy();
		}
	}
	if (instance_exists(EnemyOverlayFan)) {
		with (EnemyOverlayFan) {
			silent_death = true;
			instance_destroy();
		}
	}

	// Destroy all the enemies we originally spawned
	if (ds_exists(_lvl_obj.instances, ds_type_list)) {
		var _num_instances = ds_list_size(_lvl_obj.instances);
		for (var _i = 0; _i < _num_instances; _i++) {
			var _this_instance = _lvl_obj.instances[| _i];
			if (is_undefined(_this_instance))
				continue;
			if (instance_exists(_this_instance)) {
				_this_instance.silent_death = true; // make sure no sfx plays on death
				instance_destroy(_this_instance);
			}
		}
	
		ds_list_destroy(_lvl_obj.instances);
	}

	// Destroy any remaining enemies in the room
	if (instance_exists(ParentEnemy)) {
		with (ParentEnemy) {
			silent_death = true;
			instance_destroy();
		}
	}

	// Now that all the entities have been destroyed, spawn some fresh ones into the room

	var _spawn_list = _lvl_obj.spawn_list;
	var _spawn_list_size = ds_list_size(_spawn_list);
	_lvl_obj.instances = ds_list_create();
	
	for (var _j = 0; _j < _spawn_list_size; _j++) {
				
				
		var _inst_spawn_data = _spawn_list[| _j];
		var _id = _inst_spawn_data[? "id"];
		var _name = _inst_spawn_data[? "name"];
		var _x = _inst_spawn_data[? "x"];
		var _y = _inst_spawn_data[? "y"];
		var _type = _inst_spawn_data[? "type"];
		var _visible = _inst_spawn_data[? "visible"];
		var _rotation = _inst_spawn_data[? "rotation"];
		var _width = _inst_spawn_data[? "width"];
		var _height = _inst_spawn_data[? "height"];
		var _properties = _inst_spawn_data[? "properties"];
				
		var _new_entity = level_data_spawn_entity(_id, _name, _x, _y, _type, _visible, _rotation, _width, _height, _properties); // returns the new object's ID
		ds_list_add(_lvl_obj.instances, _new_entity);
	}
}