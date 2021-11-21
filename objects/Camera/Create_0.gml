/// @description Insert description here
// You can write your code in this editor
ds_draw_object_depth_sort = ds_grid_create(2, 1);

weapon_hud_xoff = 12;
weapon_hud_yoff = 5;
weapon_box_width = sprite_get_width(sprHUDWeapons);

lives_hud_xoff = 12;
lives_hud_yoff = 19;

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