/// @function create_textbox(index);
/// @param {real} index The dialogue index to load

function create_textbox(_index){
	var _tbox = instance_create_depth(Camera.x, Camera.y, Camera.depth, Textbox);
	with (_tbox) {
		curr_port = Game.text_contents[# 0, _index];
		curr_name = Game.text_contents[# 1, _index];
		curr_text = Game.text_contents[# 2, _index];
		next_proceed_value = Game.text_contents[# 3, _index];
	}
}