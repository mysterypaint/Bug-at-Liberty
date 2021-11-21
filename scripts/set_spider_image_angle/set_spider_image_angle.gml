// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function set_spider_image_angle(_angle) {
	switch(round(_angle / 45)) {
		case 8:
		case 0: // 0 Degrees
			img_diagonal_angle = false;
			return 0;
		case 1: // 45 Degrees
			img_diagonal_angle = true;
			return 0;
		case 2: // 90 Degrees
			img_diagonal_angle = false;
			return 90;
		case 3: // 135 Degrees
			img_diagonal_angle = true;
			return 90;
		case 4: // 180 Degrees
			img_diagonal_angle = false;
			return 180;
		case 5: // 225 Degrees
			img_diagonal_angle = true;
			return 180;
		case 6: // 270 Degrees
			img_diagonal_angle = false;
			return 270;
		case 7: // 315 Degrees
			img_diagonal_angle = true;
			return 270;
	}
}