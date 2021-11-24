/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

spr_index = sprite_index;

img_index = 0;
img_speed = 0;

move_speed = 0.2;

ani_max_frames = 8;

hp = 50;

move_timer_min = 10;
move_timer_max = 200;
move_timer = irandom_range(0, move_timer_min);

move_angle = irandom(360);