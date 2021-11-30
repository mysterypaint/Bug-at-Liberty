// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function level_data_spawn_entity(_id, _name, _x, _y, _type, _visible, _rotation, _width, _height, _properties) {
	
	if (_x < Game.checkpoint)
		return noone; // Do not spawn this entity if the camera already passed it.
	
	var _obj_id = noone;
	
	switch(_name) {
		case "EnemyPrayingMantis":
			_obj_id = instance_create_depth(_x, _y + 16, 0, EnemyPrayingMantis);
			break;
		case "EnemyDungBeetle":
			_obj_id = instance_create_depth(_x, _y + 16, 0, EnemyDungBeetle);
			with (_obj_id) {
				if (!is_undefined(_properties)) {
						var _num_props = ds_list_size(_properties);
						for (var _i = 0; _i < _num_props; _i++) {
							var _this_property = _properties[| _i];
							var _prop_name = _this_property[? "name"];
							var _prop_type = _this_property[? "type"];
							var _prop_value = _this_property[? "value"];
					
							switch(_prop_name) {
								case "move_right_first":
									move_right_first = _prop_value;
									break;
							}
						}
					}
			}
			break;
		case "EnemyDungBall":
			_obj_id = instance_create_depth(_x, _y + 16, 0, EnemyDungBall);
			break;
		case "HelperBugCapsulePrison":
			var _num_cages = instance_number(HelperBugCapsulePrison);
			if (_num_cages < 3) {
				_obj_id = instance_create_depth(_x + 10, _y + 16, 0, HelperBugCapsulePrison);
			
				with (_obj_id) {
					if (!is_undefined(_properties)) {
							var _num_props = ds_list_size(_properties);
							for (var _i = 0; _i < _num_props; _i++) {
								var _this_property = _properties[| _i];
								var _prop_name = _this_property[? "name"];
								var _prop_type = _this_property[? "type"];
								var _prop_value = _this_property[? "value"];
					
								switch(_prop_name) {
									case "bug_type":
										bug_type = _prop_value;
										break;
								}
							}
						}
				}
			
				// If we already have this bug, just destroy the capsule and make it impossible to get a new bug from this capsule
				var _inst_ship = Ship;
				for (var _i = 2; _i >= 0; _i--) {
					var _this_helper = _inst_ship.helpers[_i];
					if (_this_helper.bug_type == _obj_id.bug_type) {
						with (_obj_id) {
							sprite_index = sprCapsulePrisonDestroyed;
							spr_index = sprite_index;
							state = EnemyStates.DYING;
						}
					}
				}
			}
			break;
		case "Checkpoint":
			_obj_id = instance_create_depth(_x, _y, 0, Checkpoint);
			break;
		case "EnemyWaspNest":
			_obj_id = instance_create_depth(_x, _y, 0, EnemyWaspNest);
			break;
		case "EnemyGrasshopper":
			_obj_id = instance_create_depth(_x, _y + 16, 0, EnemyGrasshopper);
			break;
		case "EnemyHandSingleVertical":
			_obj_id = instance_create_depth(_x, _y, 0, EnemyHandSingleVertical);
			
			with (_obj_id) {
				moving_up = choose(false, true);
			
				if (!is_undefined(_properties)) {
					var _num_props = ds_list_size(_properties);
					for (var _i = 0; _i < _num_props; _i++) {
						var _this_property = _properties[| _i];
						var _prop_name = _this_property[? "name"];
						var _prop_type = _this_property[? "type"];
						var _prop_value = _this_property[? "value"];
					
						switch(_prop_name) {
							case "wait_timer":
								wait_timer = _prop_value;
								break;
							case "is_foot":
								if (_prop_value == true) {
									foot_variation = choose(1, 2);
									
									if (foot_variation == 1) {
										sprite_index = sprFeetVertical1;
									} else {
										sprite_index = sprFeetVertical2;
									}
									spr_index = sprite_index;
									body_extension.sprite_index = sprLegHorizontal1;
									hand_height = 8;
									arm_height = 320 - hand_height;
									x_offset = 0;//-hand_width;
									body_extension.spr_index = body_extension.sprite_index;
									body_extension.mask_index = body_extension.spr_index;
								}
								break;
						}
					}
				}
			
				if (moving_left) {
					img_xscale = -1;
					body_extension.img_xscale = -1;
				}
			}
			break;
		case "EnemyHandSingleHorizontal":
			_obj_id = instance_create_depth(_x, _y, 0, EnemyHandSingleHorizontal);
			
			with (_obj_id) {
				moving_left = choose(false, true);
			
				if (!is_undefined(_properties)) {
					var _num_props = ds_list_size(_properties);
					for (var _i = 0; _i < _num_props; _i++) {
						var _this_property = _properties[| _i];
						var _prop_name = _this_property[? "name"];
						var _prop_type = _this_property[? "type"];
						var _prop_value = _this_property[? "value"];
					
						switch(_prop_name) {
							case "wait_timer":
								wait_timer = _prop_value;
								break;
							case "is_foot":
								if (_prop_value == true) {
									sprite_index = sprFeetHorizontal1;
									spr_index = sprite_index;
									body_extension.sprite_index = sprLegHorizontal1;
									hand_width = 8;
									arm_width = 320 - hand_width;
									x_offset = 0;//-hand_width;
									body_extension.spr_index = body_extension.sprite_index;
									body_extension.mask_index = body_extension.spr_index;
								}
								break;
						}
					}
				}
			
				if (moving_left) {
					img_xscale = -1;
					body_extension.img_xscale = -1;
				}
			}
			break;
		case "EnemySpiderLarge":
			_obj_id = instance_create_depth(_x, _y, 0, EnemySpiderLarge);
			break;
		case "EnemySpiderSmall":
			_obj_id = instance_create_depth(_x, _y, 0, EnemySpiderSmall);
			break;
		case "EnemyCockroach":
			_obj_id = instance_create_depth(_x + 8, _y + 16, 0, EnemyCockroach);
			
			if (!is_undefined(_properties)) {
				var _num_props = ds_list_size(_properties);
				for (var _i = 0; _i < _num_props; _i++) {
					var _this_property = _properties[| _i];
					var _prop_name = _this_property[? "name"];
					var _prop_type = _this_property[? "type"];
					var _prop_value = _this_property[? "value"];
					
					switch(_prop_name) {
						case "initially_flying":
							initially_flying = _prop_value;
							break;
					}
				}
			}
			break;
	}
	//_obj_id.visible = _visible;
	return _obj_id;
}