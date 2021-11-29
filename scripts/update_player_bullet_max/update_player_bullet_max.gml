// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_player_bullet_max(_bullet_type) {
	update_player_bullet_max_internal(_bullet_type);
	
	var _num_helper_bugs = HelperBug;
	for (var _i = 0; _i < _num_helper_bugs; _i++) {
		var _this_helper_bug = instance_find(HelperBug, _i);
		with (_this_helper_bug) {
			update_player_bullet_max_internal(_bullet_type);
		}
	}
}