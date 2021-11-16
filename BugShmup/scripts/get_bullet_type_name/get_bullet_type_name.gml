// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_bullet_type_name(){
	switch(Ship.bullet_type) {
		case BulletTypes.BEE:
			return "Bee";
		case BulletTypes.DRAGONFLY:
			return "Dragonfly";
		case BulletTypes.LADYBUG:
			return "Ladybug";
		case BulletTypes.MOSQUITO:
			return "Mosquito";
		case BulletTypes.STAG_BEETLE:
			return "Stag Beetle";
		case BulletTypes.TERMITE:
			return "Termite";
	}
	
	return "Undefined";
}