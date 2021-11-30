/// @description State Machine; Kill if <0 HP
if (hp <= 0 && hp > -99999)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
	
		var _num_dung_balls = instance_number(EnemyDungBall);
		for (var _i = 0; _i = _num_dung_balls; _i++) {
			var _this_ball = instance_find(EnemyDungBall, _i);
			if (instance_exists(_this_ball))
				_this_ball.depth = depth + 1;
		}
	
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else {
			state = EnemyStates.MOVING;
			can_hurt_player = true;
			img_speed = 0.2;
			if (!move_right_first)
				move_speed *= -1;
			hsp = move_speed;
			img_xscale = -sign(hsp);
		}
		break;
	case EnemyStates.IDLE:
		break;
	case EnemyStates.MOVING:
		
		if (grounded) {
			if (!tile_place_meeting(x + (Game.TILE_SIZE * sign(hsp)), y + 1, 1)) {
				
				move_speed *= -1;
				hsp = move_speed;
			}
		
			var _ball = instance_place(x + hsp, y, EnemyDungBall);
		
			if (_ball != noone) {
				if (_ball.state != EnemyStates.FALLING) {
					hsp = sign(hsp) * abs(move_speed) / 2;
					_ball.hsp = hsp;
					_ball.img_speed = img_speed / 2;
					if (!audio_is_playing(sfxEnemyDungBeetleRollingBall) && Game.state != GameStates.PAUSED)
						sfx_play(sfxEnemyDungBeetleRollingBall);
				}
			}
			
			
			// Horizontal wall collision
			if (tile_place_meeting(x + hsp, y, 1)) {
				while (!tile_place_meeting(x + sign(hsp), y, 1)) {
					x += sign(hsp);
					
				}
				hsp *= -1;
			}
			
			if (hsp > 0)
				img_xscale = -1;
			else
				img_xscale = 1;
			x += hsp * Game.dt;
		}
		
		
		if (vsp < grav_max)
			vsp += grav * Game.dt;
			
		if (tile_place_meeting(x, y + 1, 1) && vsp >= 0) {
			while (!tile_place_meeting(x, y + 1, 1)) {
				y++;
			}
			vsp = 0;
			grounded = true;
			img_index_offset = 0;
		} else {
			grounded = false;
		}
		
		y += vsp * Game.dt;
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