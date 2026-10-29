class_name BattleService
extends RefCounted

var move_service    : BattleMoveSystem
var pathes          : BattleScenePathes
var displayer       : MapDisplayer
#var field_displayer : FieldDrawer
#var cells_displayer : CellsDrawer

var focused_cell : Vector2i

static func get_dependencies() -> Array:
	return 	[
				BattleMoveSystem, 
				BattleScenePathes, 
				MapDisplayer,
				#IsometricCellDrawer, 
				#IsometricFieldDrawer
			]

func _init(
		new_move_service : BattleMoveSystem,
		pathes_node      : BattleScenePathes,
		map_displayer    : MapDisplayer,
		#drawer_cell      : IsometricCellDrawer,
		#drawer_field     : IsometricFieldDrawer,
		) -> void:
	move_service    = new_move_service
	pathes          = pathes_node
	displayer       = map_displayer
	#cells_displayer = drawer_cell
	#field_displayer = drawer_field
	pass
	
