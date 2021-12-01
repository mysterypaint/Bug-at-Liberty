/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

cam_bounds_x_min = Game.TILE_SIZE * 4;
cam_bounds_y_min = Game.TILE_SIZE * 4;
cam_bounds_x_max = Game.base_res_width + Game.TILE_SIZE * 4;
cam_bounds_y_max = Game.base_res_height + Game.TILE_SIZE * 4;

silent_death = false;
state = EnemyStates.UNLOADED;
can_hurt_player = false;
has_small_explosion = true;
defeat_animation_started = false;

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

hsp = 0;
vsp = 0;

shoot_x_off = 34;
shoot_y_off = 137;

hp = -99999; // Invincible
next_attack_timer_reset = 450;
next_attack_timer = irandom(next_attack_timer_reset);

sneeze_cooldown_timer_reset = 80;
sneeze_cooldown_timer = 0;

my_goggles = instance_create_depth(x, y, depth + 10, HumanBossGoggles);
my_goggles.parent_id = id;
eye_shatter_sfx_played = false;

wait_timer_reset = 180;