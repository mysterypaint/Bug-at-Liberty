/// @description Insert description here
// You can write your code in this editor
switch(bullet_type) {
	case BulletTypes.LADYBUG:
		hsp = 4;
		vsp = 0;
		x += hsp * Game.dt;
		y += vsp * Game.dt;
		break;
	case BulletTypes.BEE:
		hsp = 4;
		vsp = 0;
		x += hsp * Game.dt;
		y = y + sin(x * 70) * 5 * Game.dt;
		break;
	case BulletTypes.TERMITE:
		hsp = 4;
		//vsp = 0;
		x += hsp * Game.dt;
		y += vsp * Game.dt;
		break;
	case BulletTypes.DRAGONFLY:
		vsp = 0;
		x += hsp * Game.dt;
		y += vsp * Game.dt;
		break;
	case BulletTypes.MOSQUITO:
		hsp = 4;
		vsp = 0;
		x += hsp * Game.dt;
		y += vsp * Game.dt;
		break;
	case BulletTypes.STAG_BEETLE:
		vsp = 0;
		x += hsp * Game.dt;
		y += vsp * Game.dt;
		break;
}

if (tile_place_meeting(x, y, 1) || place_meeting(x, y, ParentSolid) || x >= Camera.x + Game.base_res_width + Game.TILE_SIZE  || x <= Camera.x) {
	if (!extra_bullet) { // Make sure this bullet didn't spawn simultaneously with another
		with(parent_id) {
			bullet_count--; // Forget about this bullet within the ship
		}
	} else if (extra_bullet) {
		with(parent_id) {
			bullet_count_two--; // Forget about this bullet within the ship
		}
	}
	
	instance_destroy();
}

