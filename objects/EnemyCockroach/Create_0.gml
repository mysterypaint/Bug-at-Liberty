/// @description Insert description here
// You can write your code in this editor
shoot_timer_max_val = 200;
shoot_timer_next = irandom(shoot_timer_max_val);
shoot_timer = shoot_timer_next;
shoot_next_bullet = irandom(1);
bullet_shooting_speed[0] = 0.8;
bullet_shooting_speed[1] = 1.7;

bullets[0] = EnemyBulletSmall;
bullets[1] = EnemyBulletLarge;

