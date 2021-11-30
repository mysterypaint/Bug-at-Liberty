/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
ani_max_frames = sprite_get_number(spr_index);
img_speed = 0.5;
img_index = 0;
atk_stat = 0.2;

hurt_enemies = ds_list_create();

sfx_play(sfxPlayerExplosion);