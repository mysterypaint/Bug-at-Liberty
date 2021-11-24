/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
enum MantisSpells {
	NONE,
	ELECTRIC,
	WIND,
	MAX
};

cam_bounds_x_min = Game.TILE_SIZE * 4;
cam_bounds_y_min = Game.TILE_SIZE * 4;
cam_bounds_x_max = Game.base_res_width + Game.TILE_SIZE * 4;
cam_bounds_y_max = Game.base_res_height + Game.TILE_SIZE * 4;

state = EnemyStates.UNLOADED;
can_hurt_player = false;

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

ani_max_frames = sprite_get_number(spr_index);
time_alive = 0;

hsp = 0;
vsp = 0;

hp = 55;

cast_timer_reset = 200;
cast_timer = cast_timer_reset;
spell_duration_timer = 0;
casting_sprites[MantisSpells.NONE] = sprPrayingMantisIdle;
casting_sprites[MantisSpells.ELECTRIC] = sprPrayingMantisElectric;
casting_sprites[MantisSpells.WIND] = sprPrayingMantisFan;
casting_sprites[MantisSpells.MAX] = sprPrayingMantisIdle;

spell_durations[MantisSpells.NONE] = 0;
spell_durations[MantisSpells.ELECTRIC] = 100;
spell_durations[MantisSpells.WIND] = 300;
spell_durations[MantisSpells.MAX] = 0;
curr_spell = MantisSpells.NONE;