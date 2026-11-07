class_name FieldDrawer
extends Drawer

var   vertical_points  : Array
var horizontal_points  : Array

var battlefield_parameters : BattleFieldParameters : set = set_battlefield_parameters
 
var field_params : FieldDrawerParameters : 
	get:
		return parameters as FieldDrawerParameters
	set(value):
		return

func set_battlefield_parameters(params : BattleFieldParameters) -> void:
	if  battlefield_parameters != null && battlefield_parameters != params:
		battlefield_parameters.parameters_changed.disconnect(update_parameters)
	if  params != null && battlefield_parameters != params:
		params.parameters_changed.connect(update_parameters)
	battlefield_parameters = params
	pass

func inject_dependencies(
		pathes_node        : BattleScenePathes,
		displayer          : MapDisplayer,
		params             : FieldDrawerParameters,
		battlefield_params : BattleFieldParameters,
		) -> void:
	set_up(pathes_node.main_map, displayer, params, battlefield_params)
	pass

func set_up(
		_layer             : TileMapLayer, 
		_drawer            : Node2D, 
		params             : FieldDrawerParameters, 
		battlefield_params : BattleFieldParameters
	) -> void:
	layer                  = _layer
	drawer                 = _drawer
	parameters             = params
	battlefield_parameters = battlefield_params
	pass

func draw() -> void:
	pass
