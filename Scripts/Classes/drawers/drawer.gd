@abstract
class_name Drawer
extends RefCounted

var layer               : TileMapLayer
var drawer              : Node2D
var draw_flag           : bool            = true
var parameters          : DrawerParameters : set = set_parameters

var cell_position_lamda : Callable = func (cell : Vector2i) -> Vector2:
	return layer.map_to_local.call(cell) - drawer.position
var tile_size_lamda     : Callable = func () -> Vector2i:
	return get_cell_size()

func get_cell_size() -> Vector2i:
	return layer.tile_set.tile_size
	pass

func set_parameters(new_parameters : DrawerParameters) -> void:
	if  parameters != null && parameters != new_parameters:
		parameters.parameters_changed.disconnect(update_parameters)
	if  parameters != new_parameters:
		parameters =  new_parameters
		if  parameters != null:
			parameters.parameters_changed.connect(update_parameters)
	update_parameters()
	pass

func update_parameters() -> void:
	pass
