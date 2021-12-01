// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function boss_spawn_hand(_name, _is_foot, _wait_timer) {
	
	var _obj_id = noone;
	
	switch(_name) {
		case "EnemyHandHorizontal":
			_obj_id = instance_create_depth(x, y, 0, EnemyHandHorizontal);
			
			with (_obj_id) {
				wait_timer = _wait_timer;
				is_foot = _is_foot;
			}
			break;
		case "EnemyHandVertical":
			_obj_id = instance_create_depth(x, y, 0, EnemyHandVertical);
			
			with (_obj_id) {
				wait_timer = _wait_timer;
				is_foot = _is_foot;
			}
			break;
		case "EnemyHand":
			_obj_id = instance_create_depth(x, y, 0, EnemyHand);
			break;
		case "EnemyHandSingleVertical":
			_obj_id = instance_create_depth(x, y, 0, EnemyHandSingleVertical);
			
			with (_obj_id) {
				moving_up = choose(false, true);
				wait_timer = _wait_timer;
				if (_is_foot) {
					sprite_index = sprFeetVertical;
					spr_index = sprite_index;
					//body_extension.sprite_index = sprLegHorizontal1;
					hand_height = 8;
					arm_height = 320 - hand_height;
					y_offset = 0;//-hand_width;
					//body_extension.spr_index = body_extension.sprite_index;
					//body_extension.mask_index = body_extension.spr_index;
				}
			
				if (moving_up) {
					img_yscale = -1;
					imageyscale = img_yscale;
					//body_extension.img_yscale = -1;
				}
			}
			break;
		case "EnemyHandSingleHorizontal":
			_obj_id = instance_create_depth(x, y, 0, EnemyHandSingleHorizontal);
			
			with (_obj_id) {
				moving_left = choose(false, true);
				wait_timer = _wait_timer;
				if (_is_foot) {
					sprite_index = sprFeetHorizontal1;
					spr_index = sprite_index;
					body_extension.sprite_index = sprLegHorizontal1;
					//hand_width = 8;
					arm_height = 180;// - hand_width;
					x_offset = 0;//-hand_width;
					body_extension.spr_index = body_extension.sprite_index;
					body_extension.mask_index = body_extension.spr_index;
				}
				
				if (moving_left) {
					img_xscale = -1;
					body_extension.img_xscale = -1;
				}
			}
			break;
	}
	//_obj_id.visible = _visible;
	return _obj_id;
}