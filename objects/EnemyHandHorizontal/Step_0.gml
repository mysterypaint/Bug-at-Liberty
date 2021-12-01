/// @description Insert description here
switch (state) {
	case EnemyStates.UNLOADED:
		state = EnemyStates.IDLE;
		break;
	case EnemyStates.IDLE:
		var _hand_1 = instance_create_depth(x, y, 0, EnemyHandSingleHorizontal);
		var _hand_2 = instance_create_depth(x, y, 0, EnemyHandSingleHorizontal);
		var _wait_timer = wait_timer;
		var _is_foot = is_foot;
			
		with (_hand_1) {
			moving_left = true;
			dual_slam = true;
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
				
			// Only for hands moving left
			img_xscale = -1;
			body_extension.img_xscale = -1;
		}
			
		with (_hand_2) {
			moving_left = false;
			dual_slam = true;
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
		}
		
		ds_list_add(Game.level_data_obj.instances, _hand_1);
		ds_list_add(Game.level_data_obj.instances, _hand_2);
		state = EnemyStates.DYING;
		break;
	case EnemyStates.DYING:
		silent_death = true;
		instance_destroy();
		break;
}