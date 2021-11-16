/// @description Insert description here


move_x = max(keyboard_check(key_right), keyboard_check(key_right_alt), 0) - max(keyboard_check(key_left), keyboard_check(key_left_alt), 0);
move_y = max(keyboard_check(key_down), keyboard_check(key_down_alt), 0) - max(keyboard_check(key_up), keyboard_check(key_up_alt), 0);


key_shoot_pressed = max(keyboard_check(key_shoot), keyboard_check(key_shoot_alt), 0);
key_speedchange_pressed = max(keyboard_check_pressed(key_speedchange), keyboard_check_pressed(key_speedchange_alt), 0);
key_confirm_pressed = max(keyboard_check_pressed(key_confirm), keyboard_check_pressed(key_confirm_alt), 0);

if (!keyboard_check(vk_alt))
	key_pause_pressed = max(keyboard_check(key_pause), keyboard_check(key_pause_alt), 0);
else
	key_pause_pressed = 0;

if (global_debug) {
	if (keyboard_check_pressed(ord("Q")))
		debug = !debug;
}

if (keyboard_check_pressed(vk_escape))
	game_end();