/// @description Insert description here
switch (state) {
	case EnemyStates.UNLOADED:
		if (is_foot) {
			sprite_index = sprFeetVertical;
			spr_index = sprite_index;
			//body_extension.sprite_index = sprLegHorizontal1;
			hand_height = 8;
			arm_height = 320 - hand_height;
			y_offset = 0;//-hand_width;
			//body_extension.spr_index = body_extension.sprite_index;
			//body_extension.mask_index = body_extension.spr_index;
		}
		
		state = EnemyStates.DYING;
		break;
	case EnemyStates.DYING:
		instance_destroy();
		break;
}