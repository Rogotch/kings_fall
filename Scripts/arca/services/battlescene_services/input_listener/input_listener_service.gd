class_name InputListener
extends RefCounted

signal cell_selected(new_cell : Vector2i)

var BATTLE_SERVICE  : BattleService
#var scene_drawer    : MapDisplayer
var battle_map      : TileMapLayer
#var field_displayer : FieldDrawer
var cells_displayer : CellDrawer

var focused_cell      : Vector2i
#var focused_character : BaseCharacter

static func get_dependencies() -> Array:
	return 	[
				BattleService, 
				BattleScenePathes, 
				IsometricCellDrawer, 
				#IsometricFieldDrawer
			]

func _init(
		battle_service : BattleService,
		pathes         : BattleScenePathes,
		drawer_cell    : IsometricCellDrawer,
		#drawer_field   : IsometricFieldDrawer,
		) -> void:
	BATTLE_SERVICE  = battle_service
	battle_map      = pathes.main_map
	cells_displayer = drawer_cell
	#field_displayer = drawer_field
	pass

func physics_tick(delta: float) -> void:
	var cell : Vector2i = battle_map.local_to_map(battle_map.get_local_mouse_position())
	if  cell != focused_cell:
		focus_cell(cell)
	pass

func focus_cell(cell : Vector2i) -> void:
	focused_cell = cell
	cells_displayer.drawing_cell = cell
	pass

func select_cell() -> void:
	print("select %s cell" % focused_cell)
	cell_selected.emit(focused_cell)
	pass

#func cell_focused() -> void:
	#pass
