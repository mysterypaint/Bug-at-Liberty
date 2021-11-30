/// @description Insert description here
// You can write your code in this editor
if (delay_timer > 0) {
	delay_timer -= Game.dt;
	x += Ship.hsp * Game.dt;
	y += Ship.vsp * Game.dt;
	exit;
}

switch(bullet_type) {
	case BulletTypes.LADYBUG:
		x += (hsp + hsp_carry) * Game.dt;
		y += (vsp + vsp_carry) * Game.dt;
		break;
	case BulletTypes.BEE:
		x += (hsp + bullet_bee_missile_hsp) * Game.dt;
		bullet_bee_missile_hsp += bullet_bee_missile_hsp_rate * Game.dt;
		//y = y + sin(x * 70) * 5 * Game.dt;
		
		if (bullet_bee_vertical_timer > 0) {
			vsp = 0.5;
			bullet_bee_vertical_timer -= Game.dt;
		} else {
			vsp = 0;
		}
		
		y += (vsp + vsp_carry) * Game.dt;
		break;
	case BulletTypes.BUTTERFLY:
		x += (hsp + hsp_carry) * Game.dt;
		y += (vsp + vsp_carry) * Game.dt;
		break;
	case BulletTypes.DRAGONFLY:
		x += (hsp + hsp_carry) * Game.dt;
		y += (vsp + vsp_carry) * Game.dt;
		break;
	case BulletTypes.FIREFLY:
		if (gravity_enabled) {
			if (vsp < grav_max)
				vsp += grav;
			else
				vsp = grav_max;
		}
		x += (hsp + hsp_carry) * Game.dt;
		y += (vsp + vsp_carry) * Game.dt;
		break;
	case BulletTypes.STAG_BEETLE:
		x += (hsp + hsp_carry) * Game.dt;
		y += (vsp + vsp_carry) * Game.dt;
		break;
}

if (tile_place_meeting(x, y, 1) || place_meeting(x, y, ParentSolid) || x >= Camera.x + Game.base_res_width + Game.TILE_SIZE  || x <= Camera.x - Game.TILE_SIZE * 2) {
	instance_destroy();
}

if (death_time > 0)
	death_time -= Game.dt;
else if (death_time == 0)
	instance_destroy();