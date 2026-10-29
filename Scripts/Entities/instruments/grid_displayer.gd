@tool # tool нужен для того, чтобы сетку было видно в редакторе. При запуске игры, зависимости и отображение идут не напрямую, а через DI
extends Node2D
class_name MapDisplayer

var field_parameters : FieldDrawerParameters : set = set_field_parameters
var cells_parameters : CellsDrawerParameters : set = set_cells_parameters

var tile_layer      : TileMapLayer
var field_displayer : FieldDrawer
var cells_displayer : CellsDrawer

var cell_for_drawing : Vector2i

static func get_inject_dependencies() -> Array:
	return [
		DrawersFactory, 
		BattleScenePathes,
		BattleSceneParameters,
		]
	pass

func inject_dependencies(
		d_factory    : DrawersFactory,
		pathes       : BattleScenePathes,
		parameters   : BattleSceneParameters,
		) -> void:
	cells_displayer  = d_factory.create(parameters.cells_parameters, DrawersFactory.TYPE_DRAWER.CELLS, DrawersFactory.CELL_TYPE.ISOMETRIC)
	field_displayer  = d_factory.create(parameters.field_parameters, DrawersFactory.TYPE_DRAWER.FIELD, DrawersFactory.CELL_TYPE.ISOMETRIC, DrawersFactory.FIELD_TYPE.CELLS)
	tile_layer       = pathes.main_map
	pass

func set_field_parameters(params : FieldDrawerParameters) -> void:
	#if  field_parameters != null && field_parameters != params:
		#field_parameters.free()
	field_parameters = params
	pass

func set_cells_parameters(params : CellsDrawerParameters) -> void:
	#if  cells_parameters != null && cells_parameters != params:
		#cells_parameters.free()
	cells_parameters = params
	pass

func tool_set_up() -> void:
	if  Engine.is_editor_hint() && get_parent() is TileMapLayer:
		tile_layer = get_parent()
		#field_displayer  = IsometricFieldDrawer.new()
		#field_displayer.set_up(tile_layer, self, field_size, field_start_cell)
		field_displayer  = FieldCellsDrawer.new()
		field_displayer.set_up(tile_layer, self, field_parameters)
		field_displayer.set_up_cells_drawer(IsometricCellDrawer.new())
		cells_displayer = IsometricCellDrawer.new()
		cells_displayer.set_up(tile_layer, self, cells_parameters)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tile_layer != null:
		queue_redraw()
	pass

func _draw() -> void:
	if  field_displayer != null:
		field_displayer.draw()
	if  cells_displayer != null:
		if  Engine.is_editor_hint():
			cells_displayer.drawing_cell = tile_layer.local_to_map(get_local_mouse_position())
		cells_displayer.draw_cell()
		
	pass
