/// @description Insert description here


move_x = max(keyboard_check(key_right), keyboard_check(key_right_alt), 0) - max(keyboard_check(key_left), keyboard_check(key_left_alt), 0);
move_y = max(keyboard_check(key_down), keyboard_check(key_down_alt), 0) - max(keyboard_check(key_up), keyboard_check(key_up_alt), 0);


key_shoot_pressed = max(keyboard_check(key_shoot), keyboard_check(key_shoot_alt), 0);
key_weapon_change_forward_pressed = max(keyboard_check_pressed(key_weapon_change_forward), keyboard_check_pressed(key_weapon_change_forward_alt), 0);
key_weapon_change_backward_pressed = max(keyboard_check_pressed(key_weapon_change_backward), keyboard_check_pressed(key_weapon_change_backward_alt), 0);
key_confirm_pressed = max(keyboard_check_pressed(key_confirm), keyboard_check_pressed(key_confirm_alt), 0);
key_cancel_pressed = max(keyboard_check_pressed(key_cancel), keyboard_check_pressed(key_cancel_alt), 0);

if (!keyboard_check(vk_alt))
	key_pause_pressed = max(keyboard_check(key_pause), keyboard_check(key_pause_alt), 0);
else
	key_pause_pressed = 0;

if (global_debug) {
	if (keyboard_check_pressed(ord("Q")))
		debug = !debug;
}

if (debug) {
	if (keyboard_check_pressed(ord("M"))) {
		mute_bgm = !mute_bgm;
		
		if (mute_bgm) {
			audio_group_set_gain(AudioGroupBGM, 0, 0);
		} else
			audio_group_set_gain(AudioGroupBGM, 0.8, 0);
	}
	
}

if (keyboard_check_pressed(vk_escape))
	game_end();

// Step the BGM, if defined
bgm_step(curr_bgm);