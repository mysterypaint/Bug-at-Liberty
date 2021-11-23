/// @description Insert description here
layers = undefined;
instances = undefined; // The list of enemies that have been spawned during room initialization
spawn_list = undefined; // The list of enemies to spawn; Used when re-spawning all entities on the same map (e.g. upon death)
tilesets = undefined;
tileset_gids = undefined;
shadow_layer = -1;

collision_layer = noone;
collision_layer_tiles = undefined;