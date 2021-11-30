/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

state = EnemyStates.UNLOADED;

spr_index = sprite_index;
img_index = 0;
img_index_offset = 0;
img_speed = 0.2;
img_angle = 0;
img_xscale = 1;
img_yscale = 1;
img_alpha = 1;
img_color = c_white;
img_diagonal_angle = false;

ani_max_frames = 2;
time_alive = 0;
move_angle = 0;
move_speed = 2;

hsp = 0;
vsp = 0;

hp = 2;

// Timer to count how long the Wasp should wait before flying at the player
move_timer_reset = 50;
move_timer = move_timer_reset;

// Count how many times this Wasp has attempted to fly at the player
times_moved = 0;

// Timer to count how long the wasp should fly toward the player, whenever it is moving
reorient_timer_reset = 50;
reorient_timer = reorient_timer_reset;