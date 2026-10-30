class_name InputListener
extends RefCounted

signal cell_selected(new_cell : Vector2i)

var battle_map        : TileMapLayer
var cells_displayer   : CellsDrawer

var focused_cell      : Vector2i
var input_enabled     : bool = true

static func get_dependencies() -> Array:
	return 	[
				BattleScenePathes, 
				MapDisplayer,
			]

func _init(
		pathes         : BattleScenePathes,
		displayer      : MapDisplayer,
		) -> void:
	battle_map      = pathes.main_map
	cells_displayer = displayer.cells_displayer
	pass

func physics_tick(delta: float) -> void:
	var cell : Vector2i = battle_map.local_to_map(battle_map.get_local_mouse_position())
	if  cell != focused_cell && cells_displayer != null:
		focus_cell(cell)
	pass

func focus_cell(cell : Vector2i) -> void:
	focused_cell = cell
	cells_displayer.drawing_cell = cell
	pass

func select_cell() -> void:
	if !input_enabled:
		return
	cell_selected.emit(focused_cell)
	pass
