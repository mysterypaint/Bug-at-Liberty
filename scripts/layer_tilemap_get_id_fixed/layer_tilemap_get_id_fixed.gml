// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function layer_tilemap_get_id_fixed(_layer) {
    var els = layer_get_all_elements(_layer);
    var n = array_length_1d(els);
    for (var i = 0; i < n; i++) {
        var el = els[i];
        if (layer_get_element_type(el) == layerelementtype_tilemap) {
        	return el;
        }
    }
    return -1;
}