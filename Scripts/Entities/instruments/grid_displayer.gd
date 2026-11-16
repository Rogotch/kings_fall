@tool # tool нужен для того, чтобы сетку было видно в редакторе. При запуске игры, зависимости и отображение идут не напрямую, а через DI
extends Node2D
class_name MapDisplayer

var battlefield_parameters : BattleFieldParameters : set = set_battle_field_parameters
var field_parameters       : FieldDrawerParameters : set = set_field_parameters
var cells_parameters       : CellsDrawerParameters : set = set_cells_parameters

var tile_layer             : TileMapLayer
var field_displayer        : FieldDrawer
var cells_displayer        : CellsDrawer

var cell_for_drawing       : Vector2i

var layers_node            : Node2D
var typed_layers           : Array[TileMapLayer]

static func get_inject_dependencies() -> Array:
	return [
		FactoryDrawers, 
		BattleScenePathes,
		BattleSceneParameters,
		]
	pass

func inject_dependencies(
		d_factory  : FactoryDrawers,
		pathes     : BattleScenePathes,
		parameters : BattleSceneParameters,
		) -> void:
	cells_displayer  = d_factory.create_cells_drawer(parameters.cells_drawer_parameters)
	field_displayer  = d_factory.create_field_drawer(
									parameters.field_drawer_parameters, 
									parameters.battle_field_parameters,
									FactoryDrawers.FIELD_TYPE.CELLS)
	tile_layer       = pathes.main_map
	pass

func set_battle_field_parameters(params : BattleFieldParameters) -> void:
	battlefield_parameters = params
	if  field_displayer != null:
		field_displayer.battlefield_parameters = params
	pass

func set_field_parameters(params : FieldDrawerParameters) -> void:
	field_parameters = params
	pass

func set_cells_parameters(params : CellsDrawerParameters) -> void:
	cells_parameters = params
	pass

func tool_set_up() -> void:
	if  Engine.is_editor_hint() && get_parent() is TileMapLayer:
		tile_layer = get_parent()
		#field_displayer  = IsometricFieldDrawer.new()
		#field_displayer.set_up(tile_layer, self, field_size, field_start_cell)
		field_displayer  = FieldCellsDrawer.new()
		field_displayer.set_up(tile_layer, self, field_parameters, battlefield_parameters)
		field_displayer.set_up_cells_drawer(CellsDrawer.new())
		cells_displayer = CellsDrawer.new()
		cells_displayer.set_up(tile_layer, self, cells_parameters, battlefield_parameters)
	pass

func get_layers_node() -> Node2D:
	if layers_node == null:
		if has_node("layers_node"):
			layers_node = get_node("layers_node")
		else:
			layers_node = Node2D.new()
			layers_node.name = "layers_node"
			add_child(layers_node)
	return  layers_node
	pass

func init_layers_nodes() -> void:
	clear_layers()
	load_layers()
	pass

func clear_layers() -> void:
	typed_layers.clear()
	for i in layers_node.get_child_count():
		layers_node.get_child(i).queue_free()
	pass

func load_layers() -> void:
	typed_layers.clear()
	var child_count : int = layers_node.get_child_count()
	for i in battlefield_parameters.draw_order.size():
		var layer : TileMapLayer = TileMapLayer.new()
		layer.tile_set = tile_layer.tile_set
		layers_node.add_child(layer)
		typed_layers.append(layer)
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
			var focused_cell : Vector2i = tile_layer.local_to_map(get_local_mouse_position())
			if (battlefield_parameters != null
				&& battlefield_parameters.get_filled_rect().has_point(focused_cell)):
				cells_displayer.ClearDrawingCells()
				cells_displayer.SetDrawingCells(CellsDrawer.CELL_TYPE.NONE, Array([focused_cell], TYPE_VECTOR2I, "", null))
				cells_displayer.draw()
		else:
			cells_displayer.draw()
	pass
