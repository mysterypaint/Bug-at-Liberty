/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < bbox_left)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			draw_me = true;
			//body_extension.can_hurt_player = true;
			//mask_index = sprite_index;
			if (!moving_up) {
				y = Camera.y - Game.base_res_height;
				//body_extension.x = -500;
			} else {
				arm_height = 180;
				y = Camera.y + Game.base_res_height + arm_height + y_offset;
				//body_extension.x = x + arm_width;
			}
			
			if (dual_slam)
				impact_point_offset = Game.base_res_height / 2;
			else
				impact_point_offset = 0;
			
			if (wait_timer > 0)
				sfx_play(sfxCautionWarning);
			//y = Ship.y;
			x = Ship.x;
			//body_extension.y = y;
			//body_extension.mask_index = body_extension.sprite_index;
		}
		break;
	case EnemyStates.IDLE:
		if (wait_timer > 0) {
			wait_timer -= Game.dt;
			//y = Ship.y;
		} else {
			wait_timer = -1;
			state = EnemyStates.ATTACKING;
			can_hurt_player = true;
			punching_state = 1;
		}
		
		//body_extension.y = y;
		if (!moving_up) {
			y = Camera.y - Game.base_res_height + y_offset;
			//body_extension.x = x - arm_width - 500;
		} else {
			y = Camera.y + Game.base_res_height + arm_height + y_offset;
			//body_extension.x = x + arm_width;
		}
		break;
	case EnemyStates.ATTACKING:
		if (!moving_up) {
			y = Camera.y - Game.base_res_height + y_offset;
			if (y + sprite_height > Camera.y + Game.base_res_height - impact_point_offset) {
				punching_state = -1;
				sfx_play(sfxGenericImpactSound);
			} else if (punching_state == -1 && y_offset <= -Game.base_res_height - padding) {
				// Destroy once off-camera, as the hand/leg is retreating from the screen
				instance_destroy();
			}
		
			y_offset += punching_state * punching_speed * Game.dt;
			/*
			if (instance_exists(body_extension)) {
				body_extension.x = x - arm_width;
				body_extension.can_hurt_player = true;
			}*/
		} else {
			y = Camera.y + Game.base_res_height + arm_height + y_offset;
			if (y + y_offset - punching_speed <= Camera.y + Camera.move_y + impact_point_offset) {
				y_offset = -arm_height;
				//y = Camera.y + Camera.move_y - y_offset;
				punching_state = -1;
				sfx_play(sfxGenericImpactSound);
			} else if (punching_state == -1 && y >= Camera.y + Game.base_res_height + arm_height + padding + Game.TILE_SIZE) {
				// Destroy once off-camera, as the hand/leg is retreating from the screen
				
				instance_destroy();
			}
		
			y_offset -= punching_state * punching_speed * Game.dt;
			/*
			if (instance_exists(body_extension))
				body_extension.x = x + arm_width;
				*/
		}
		break;
	case EnemyStates.DYING:
		break;
}
caution_img_index += caution_img_speed * Game.dt;
if (caution_img_index > caution_ani_max_frames)
	caution_img_index = 0;

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;