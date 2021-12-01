/// @description Insert description here
// You can write your code in this editor
ds_draw_object_depth_sort = ds_grid_create(2, 1);
scroll_to_boss = false;


fadeout_speed = 0;
fadeout_alpha = 0;
screenshake = 0;
screenshake_xoff = 0;
screenshake_yoff = 0;

hp_hud_xoff = 11;
hp_hud_yoff = 2;
hp_hud_width = 6;
hud_sleeping_img_index = 0;
hud_sleeping_img_speed = 0.035;

weapon_hud_xoff = 130;
weapon_hud_yoff = 2;
weapon_box_width = sprite_get_width(sprHUDWeapons);

lives_hud_xoff = 13;
lives_hud_yoff = 17;

hud_alpha = 0.7;

level_data_obj = noone;

num_draw_objects = 0;

checkpoint_display_timer_reset = 400;
checkpoint_display_timer = 0;
checkpoint_display_blink_rate = 100;
checkpoint_display_visible = false;

// Default scrolling speed
move_x = 0.2;
move_y = 0;
prev_move_x = 0;
prev_move_y = 0;

hide_camera = false;

shadow_layer_alpha = 0.3922;

// Credits screen sfx flags
played_sfx_1 = false;
played_sfx_2 = false;
played_sfx_3 = false;