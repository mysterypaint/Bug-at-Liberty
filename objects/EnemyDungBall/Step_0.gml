/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.IDLE;
			can_hurt_player = true;
		}
		break;
	case EnemyStates.IDLE:
		var _x = x;
		if (hsp > 0)
			_x = bbox_left + hsp;
		else if (hsp < 0)
			_x = bbox_right + hsp;
		
		if (!tile_place_meeting_px(_x, y + 1, 1)) {
			state = EnemyStates.FALLING;
			hsp = roll_speed * sign(hsp) * Game.dt;
		} else {
			x += hsp * Game.dt;
			y += vsp * Game.dt;
		}
		break;
	case EnemyStates.FALLING:
		if (vsp < grav_max)
			vsp += grav * Game.dt;
		
		// Go back to idle if we landed on the ground
		if (tile_place_meeting(x, y + vsp, 1) && vsp > 0) {
			while (!tile_place_meeting(x, y + 1, 1)) {
				y++;
			}
			vsp = bounce_speed;
		}
		
		x += hsp * Game.dt;
		y += vsp * Game.dt;
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;