class_name Drawer
extends RefCounted

var layer             : TileMapLayer
var drawer            : Node2D
var cell_size         : Vector2i
var draw_flag         : bool            = true

var cell_position_lamda : Callable = func (cell : Vector2i) -> Vector2:
	return layer.map_to_local.call(cell) - drawer.position
var cell_size_lamda : Callable = func () -> Vector2i:
	return layer.tile_set.tile_size
