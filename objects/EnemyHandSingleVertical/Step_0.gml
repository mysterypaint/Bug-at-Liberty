/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < bbox_left)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			draw_me = true;
			//mask_index = sprite_index;
			if (!moving_left) {
				x = Camera.x + x_offset;
				body_extension.x = x - arm_width;
			} else {
				x = Camera.x + Game.base_res_width + x_offset;
				body_extension.x = x + arm_width;
			}
			y = Ship.y;
			body_extension.y = y;
			//body_extension.mask_index = body_extension.sprite_index;
		}
		break;
	case EnemyStates.IDLE:
		if (wait_timer > 0) {
			wait_timer -= Game.dt;
			y = Ship.y;
		} else {
			wait_timer = -1;
			state = EnemyStates.ATTACKING;
			punching_state = 1;
		}
		
		body_extension.y = y;
		if (!moving_left) {
			x = Camera.x + x_offset;
			body_extension.x = x - arm_width;
		} else {
			x = Camera.x + Game.base_res_width + x_offset;
			body_extension.x = x + arm_width;
		}
		break;
	case EnemyStates.ATTACKING:
		if (!moving_left) {
			x = Camera.x + x_offset;
			if (x + sprite_width > Camera.x + Game.base_res_width) {
				punching_state = -1;
			} else if (punching_state == -1 && x_offset <= -Game.base_res_width - padding) {
				// Destroy once off-camera, as the hand/leg is retreating from the screen
				instance_destroy();
			}
		
			x_offset += punching_state * punching_speed * Game.dt;
			if (instance_exists(body_extension))
				body_extension.x = x - arm_width;
		} else {
			x = Camera.x + Game.base_res_width + x_offset;
			if (bbox_left - punching_speed*2 <= Camera.x + Camera.move_x) {
				punching_state = -1;
			} else if (punching_state == -1 && x_offset >= padding + Game.TILE_SIZE) {
				// Destroy once off-camera, as the hand/leg is retreating from the screen
				instance_destroy();
			}
		
			x_offset -= punching_state * punching_speed * Game.dt;
			if (instance_exists(body_extension))
				body_extension.x = x + arm_width;
		}
		break;
	case EnemyStates.DYING:
		break;
}

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;