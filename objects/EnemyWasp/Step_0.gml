/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else
			state = EnemyStates.IDLE;
		break;
	case EnemyStates.IDLE:
		if (move_timer <= 0) {
			move_timer = move_timer_reset;
			
			move_angle = point_direction(x, y, Ship.x, Ship.y);
			hsp = lengthdir_x(move_speed, move_angle);
			vsp = lengthdir_y(move_speed, move_angle);
			
			state = EnemyStates.MOVING;
			img_index_offset = 2;
			times_moved++;
		} else {
			move_timer -= Game.dt;
		}
		break;
	case EnemyStates.MOVING:
		
		if (reorient_timer <= 0 && times_moved < 3) {
			state = EnemyStates.IDLE;
			img_index_offset = 0;
			reorient_timer = reorient_timer_reset;
		} else {
			x += hsp * Game.dt;
			y += vsp * Game.dt;
			reorient_timer -= Game.dt;
		}
		break;
	case EnemyStates.DYING:
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index + img_speed >= ani_max_frames)
	img_index = 0;

time_alive += Game.dt;