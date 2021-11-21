/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

hp = 1;
move_speed = 1;
shoot_frequency = 150;

move_timer_min = 10;
move_timer_max = 200;
move_timer = irandom_range(0, move_timer_min);

move_angle = irandom(360);