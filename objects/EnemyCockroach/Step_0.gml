/// @description Insert description here
event_inherited();

if (!instance_exists(Ship))
	exit;

direction = point_direction(x, y, Ship.x, Ship.y);

if (shoot_timer <= 0) {
	direction += irandom_range(-10, 10);
	var _new_bullet = instance_create_depth(x, y, depth, bullets[shoot_next_bullet]);
	_new_bullet.direction = direction;
	_new_bullet.spd = bullet_shooting_speed[shoot_next_bullet];
	
	shoot_timer_next = irandom(shoot_timer_max_val);
	shoot_timer = shoot_timer_next;
	shoot_next_bullet = irandom(1);
}

if (shoot_timer > 0)
	shoot_timer -= Game.dt;