/// @description Insert description here
// You can write your code in this editor
event_inherited();

shoot_timer_max_val = 65;
shoot_timer_next = irandom(shoot_timer_max_val);
shoot_timer = shoot_timer_next;
shoot_x_off = 0;
shoot_y_off = -6;


spr_flying_x_origin = sprite_get_xoffset(sprCockroachFlying);
spr_flying_y_origin = sprite_get_yoffset(sprCockroachFlying);
//bullet_shooting_speed[0] = 0.8;
//bullet_shooting_speed[1] = 1.7;

bullets[0] = EnemyBulletTypes.SMALL;
bullets[1] = EnemyBulletTypes.LARGE;

initially_flying = false;

wander_timer = 0;
wander_timer_reset = 100;

ani_max_frames = sprite_get_number(sprite_index);
wander_speed = 0.4;
facing_y = 1;

target_hsp = 0;
target_vsp = 0;
accel_rate = 0.02;

hp = 3;