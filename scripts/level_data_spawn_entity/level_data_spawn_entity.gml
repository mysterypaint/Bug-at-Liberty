// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function level_data_spawn_entity(_id, _name, _x, _y, _type, _visible, _rotation, _width, _height){
	var _obj_id = noone;
	
	switch(_name) {
		case "EnemySpiderLarge":
			_obj_id = instance_create_depth(_x, _y, 0, EnemySpider);
			break;
		case "EnemyCockroach":
			_obj_id = instance_create_depth(_x, _y, 0, EnemyCockroach);
			break;
	}
	//_obj_id.visible = _visible;
	return _obj_id;
}