/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -2)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.MOVING;
			can_hurt_player = true;
			img_speed = 0.2;
			hsp = move_speed;
		}
		break;
	case EnemyStates.IDLE:
		break;
	case EnemyStates.MOVING:
		if (!tile_place_meeting(x + (Game.TILE_SIZE * sign(hsp)), y + 1, 1)) {
			img_xscale *= -1;
			move_speed *= -1;
			hsp = move_speed;
		}
		
		var _ball = instance_place(x + hsp, y, EnemyDungBall);
		
		if (_ball != noone) {
			if (_ball.state != EnemyStates.FALLING) {
				hsp = move_speed / 2;
				_ball.hsp = hsp;
				_ball.img_speed = img_speed / 2;
				touched_ball = true;
			}
		} else if (touched_ball) {
			hsp = move_speed / 4;
		}
		x += hsp * Game.dt;
		break;
	case EnemyStates.ATTACKING:
		break;
	case EnemyStates.DYING:
		break;
}

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;