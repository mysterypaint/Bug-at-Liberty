// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function string_split(_string, _delimiter){
	/// string_split(:string, delimiter:string):array<string>
	var rl = global.string_split_list;
	var p = string_pos(_delimiter, _string), o = 1;
	var dl = string_length(_delimiter);
	ds_list_clear(rl);
	if (dl) while (p) {
	    ds_list_add(rl, string_copy(_string, o, p - o));
	    o = p + dl;
	    p = string_pos_ext(_delimiter, _string, o);
	}
	ds_list_add(rl, string_delete(_string, 1, o - 1));
	// create an array and store results:
	var rn = ds_list_size(rl);
	var rw = array_create(rn);
	for (p = 0; p < rn; p++) rw[p] = rl[|p];
	return rw;
}