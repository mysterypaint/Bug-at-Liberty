/// @description State Machine; Kill if <0 HP
if (hp <= 0)
	instance_destroy();

switch (state) {
	case EnemyStates.UNLOADED:
		if (Camera.x + Game.base_res_width < x)
			exit; // The player has not reached this enemy yet.
		else
			state = EnemyStates.IDLE;
		break;
	case EnemyStates.IDLE:
		if (move_timer > 0)
			move_timer -= Game.dt;
		else {
			state = EnemyStates.MOVING;
			img_index = 0;
			img_speed = 0.2;
			move_timer = irandom_range(move_timer_min, move_timer_max);
			move_angle = choose(irandom(360), point_direction(x, y, Ship.x, Ship.y));
			img_angle = get_octo_image_angle(move_angle);

			hsp = lengthdir_x(move_speed, move_angle);
			vsp = lengthdir_y(move_speed, move_angle);
		}
		
		if (time_alive % shoot_frequency == 0 && Game.dt > 0)
			shoot_at_player(EnemyBulletTypes.SMALL);
		
		break;
	case EnemyStates.MOVING:
		if (move_timer > 0)
			move_timer -= Game.dt;
		else {
			state = EnemyStates.IDLE;
			img_index = 0;
			img_speed = 0;
			move_timer = irandom_range(0, move_timer_min);
			hsp = 0;
			vsp = 0;
		}
		
		if (time_alive % shoot_frequency == 0 && Game.dt > 0)
			shoot_at_player(EnemyBulletTypes.SMALL);
		
		break;
	case EnemyStates.ATTACKING:
		break;
	case EnemyStates.DYING:
		break;
}

/*
var _padding = 32;

if (x + hsp + _padding < Camera.x || x + hsp > Camera.x + Game.base_res_width - _padding)
	hsp *= -1;
if (y + vsp + _padding < Camera.y || y + vsp > Camera.y + Game.base_res_height - _padding)
	vsp *= -1;
*/

collide_and_move();

// De-spawn if too far away from the camera
despawn_if_oob();

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;