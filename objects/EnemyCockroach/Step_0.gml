/// @description Insert description here
event_inherited();

if (!instance_exists(Ship))
	exit;

// Shoot at the player
if (shoot_timer <= 0) {
	var _bullet_type = choose(bullets[0], bullets[1]);
	shoot_at_player(_bullet_type);
	shoot_timer_next = irandom(shoot_timer_max_val);
	shoot_timer = shoot_timer_next;
}

if (shoot_timer > 0)
	shoot_timer -= Game.dt;

