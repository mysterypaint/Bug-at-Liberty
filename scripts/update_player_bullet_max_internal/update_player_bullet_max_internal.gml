// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_player_bullet_max_internal(_bullet_type) {
	bullet_count_max = 4;
	bullet_count_two_max = 4;
	
	if (_bullet_type == BulletTypes.DRAGONFLY || _bullet_type == BulletTypes.STAG_BEETLE) {
		bullet_count_max = 1;
		bullet_count_two_max = 1;
	}
	
	if (_bullet_type == BulletTypes.BUTTERFLY) {
		bullet_count_max = 14;
	}
	
	if (_bullet_type == BulletTypes.DRAGONFLY) {
		bullet_count_max = 2;
		bullet_count_two_max = 2;
	}
	
	if (_bullet_type == BulletTypes.FIREFLY) {
		bullet_count_max = 2;
		bullet_count_two_max = 2;
	}
}