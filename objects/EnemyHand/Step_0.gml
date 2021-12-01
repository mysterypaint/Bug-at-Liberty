/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			x = Ship.x;
			y = Ship.y;
			//can_hurt_player = true;
		}
		break;
	case EnemyStates.IDLE:
		var _cubic_val = ease_in_cubic(wait_timer / wait_timer_max);
		img_alpha = lerp(0, 1, _cubic_val);
		img_xscale = lerp(4, 1, _cubic_val);
		img_yscale = lerp(4, 1, _cubic_val);
		
		// Accelerate toward the player
		var _dir = point_direction(x, y, Ship.x, Ship.y);
		
		target_hsp = lengthdir_x(accel_rate, _dir);
		target_vsp = lengthdir_y(accel_rate, _dir);
		
		
		hsp = hsp * (1 - Game.dt * accel_rate) + target_hsp * (Game.dt * accel_rate);
		x += hsp;
		
		vsp = vsp * (1 - Game.dt * accel_rate) + target_vsp * (Game.dt * accel_rate);
		y += vsp;
		
		if (wait_timer < wait_timer_max) {
		
			wait_timer += Game.dt;
		} else {
			state = EnemyStates.ATTACKING;
			wait_timer = 40;
			img_alpha = 1;
			img_xscale = 1;
			img_yscale = 1;
			img_index = 1;
			can_hurt_player = true;
			Camera.screenshake = 20;
		}
		break;
	case EnemyStates.MOVING:
		break;
	case EnemyStates.ATTACKING:
		if (wait_timer > 0) {
			wait_timer -= Game.dt;
		} else {
			state = EnemyStates.DYING;
		}
		break;
	case EnemyStates.DYING:
		if (img_alpha > 0) {
			can_hurt_player = false;
			img_alpha -= 0.02 * Game.dt;
		} else {
			silent_death = true;
			instance_destroy();
		}
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;