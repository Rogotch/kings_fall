class_name FieldDrawer
extends Drawer

var   vertical_points  : Array
var horizontal_points  : Array

var field_params : FieldDrawerParameters : 
	get:
		return parameters as FieldDrawerParameters
	set(value):
		return

func inject_dependencies(
		pathes_node      : BattleScenePathes,
		displayer        : MapDisplayer,
		params           : FieldDrawerParameters,
		) -> void:
	set_up(pathes_node.main_map, displayer, params)
	pass

func set_up(_layer : TileMapLayer, _drawer : Node2D, params : FieldDrawerParameters) -> void:
	layer      = _layer
	drawer     = _drawer
	cell_size  = cell_size_lamda.call()
	parameters = params
	pass

func draw() -> void:
	pass
