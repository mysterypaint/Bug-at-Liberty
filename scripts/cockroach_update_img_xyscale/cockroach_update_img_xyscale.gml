// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cockroach_update_img_xyscale(_direction) {
	switch(_direction) {
		case 45: // Up-right
			img_xscale = 1;
			img_yscale = 1;
			break;
		case 135: // Up-Left
			img_xscale = -1;
			img_yscale = 1;
			break;
		case 225: // Bottom-left
			img_xscale = -1;
			img_yscale = -1;
			break;
		case 315: // Bottom-right
			img_xscale = 1;
			img_yscale = -1;
			break;
	}
}