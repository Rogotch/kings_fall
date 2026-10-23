@tool
extends Node2D
class_name MapDisplayer

@export var field_size       : Vector2i : set = set_field_size
@export var field_start_cell : Vector2i : set = set_field_start_cell

var tile_layer       : TileMapLayer
var  field_displayer : FieldDrawer
var cursor_displayer : CellDrawer

var cell_for_drawing : Vector2i

static func get_inject_dependencies() -> Array:
	return [IsometricCellDrawer, IsometricFieldDrawer, BattleScenePathes]
	pass

func inject_dependencies(
		drawer_cell  : IsometricCellDrawer, 
		drawer_field : IsometricFieldDrawer,
		pathes       : BattleScenePathes
		) -> void:
	cursor_displayer = drawer_cell
	field_displayer  = drawer_field
	tile_layer       = pathes.main_map
	pass

func _ready() -> void:
	if  Engine.is_editor_hint() && get_parent() is TileMapLayer:
		tile_layer = get_parent()
		field_displayer  = IsometricFieldDrawer.new()
		field_displayer.set_up(tile_layer, self, field_size, field_start_cell)
		cursor_displayer = IsometricCellDrawer.new()
		cursor_displayer.set_up(tile_layer, self)
	pass # Replace with function body.

func set_field_size(new_size : Vector2i) -> void:
	field_size = new_size
	if  field_displayer != null:
		field_displayer.set_size(new_size)
	pass

func set_field_start_cell(new_cell : Vector2i) -> void:
	field_start_cell = new_cell
	if  field_displayer != null:
		field_displayer.set_start_cell(new_cell)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tile_layer != null:
		queue_redraw()
	pass

func _draw() -> void:
	if  field_displayer != null:
		field_displayer.draw()
	if  cursor_displayer != null:
		if  Engine.is_editor_hint():
			cursor_displayer.drawing_cell = tile_layer.local_to_map(get_local_mouse_position())
		cursor_displayer.draw_cell()
		
	pass
