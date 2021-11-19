// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_octo_image_angle(_angle){
	switch(round(_angle / 45)) {
		case 8:
		case 0:
			img_diagonal_angle = false;
			return 0;
		case 1:
			img_diagonal_angle = true;
			return 45;
		case 2:
			img_diagonal_angle = false;
			return 90;
		case 3:
			img_diagonal_angle = true;
			return 135;
		case 4:
			img_diagonal_angle = false;
			return 180;
		case 5:
			img_diagonal_angle = true;
			return 225;
		case 6:
			img_diagonal_angle = false;
			return 270;
		case 7:
			img_diagonal_angle = true;
			return 315;
	}

}