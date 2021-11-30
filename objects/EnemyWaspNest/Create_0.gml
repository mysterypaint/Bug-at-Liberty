/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

state = EnemyStates.UNLOADED;

spr_index = sprite_index;
img_index = 0;
img_index_offset = 0;
img_speed = 0;
img_angle = 0;
img_xscale = 1;
img_yscale = 1;
img_alpha = 1;
img_color = c_white;
img_diagonal_angle = false;

ani_max_frames = sprite_get_number(spr_index);
time_alive = 0;

inv_frames_timer = 0;
blink_rate = 4;
inv_frames_timer_reset = 25;

hsp = 0;
vsp = 0;

grav = 0.07;
grav_max = 9.81;

spawn_timer_reset = 150;
spawn_timer = spawn_timer_reset;

hp = 5;