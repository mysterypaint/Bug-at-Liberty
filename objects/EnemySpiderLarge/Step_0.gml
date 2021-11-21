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
			var _toward_player = point_direction(x, y, Ship.x, Ship.y);
			if (Ship.dead)
				_toward_player = irandom(360);
			move_angle = choose(irandom(360), _toward_player); // 50/50 chance of moving toward the player, or in a random direction
			img_angle = set_spider_image_angle(move_angle);

			if (img_diagonal_angle)
				img_index_offset = 9;
			else
				img_index_offset = 0;

			hsp = lengthdir_x(move_speed, move_angle);
			vsp = lengthdir_y(move_speed, move_angle);
		}
		
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

img_index += img_speed * Game.dt;
if (img_index > ani_max_frames)
	img_index = 0;

time_alive += Game.dt;