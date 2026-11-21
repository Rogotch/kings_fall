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

var layers_node            : Node2D : get = get_layers_node 
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
	cells_displayer  = d_factory.create_cells_drawer(
									parameters.cells_drawer_parameters,
									parameters.battle_field_parameters,
									)
	field_displayer  = d_factory.create_field_drawer(
									parameters.field_drawer_parameters, 
									parameters.battle_field_parameters,
									FactoryDrawers.FIELD_TYPE.CELLS)
	tile_layer       = pathes.main_map
	set_battle_field_parameters(parameters.battle_field_parameters)
	set_field_parameters(parameters.field_drawer_parameters)
	set_cells_parameters(parameters.cells_drawer_parameters)
	init_layers_nodes()
	pass

func tool_set_up() -> void:
	if  Engine.is_editor_hint() && get_parent() is TileMapLayer:
		tile_layer = get_parent()
		init_layers_nodes()
		#field_displayer  = IsometricFieldDrawer.new()
		#field_displayer.set_up(tile_layer, self, field_size, field_start_cell)
		field_displayer  = FieldCellsDrawer.new()
		field_displayer.set_up(tile_layer, self, battlefield_parameters, field_parameters)
		field_displayer.set_up_cells_drawer(CellsDrawer.new())
		cells_displayer = CellsDrawer.new()
		cells_displayer.set_up(tile_layer, self, battlefield_parameters, cells_parameters)
	pass

#region Parameters
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

func update_parameters() -> void:
	if battlefield_parameters.draw_order.size() != typed_layers.size():
		init_layers_nodes()
	var counter : int = 0
	for type in battlefield_parameters.draw_order:
		var cell_parameters : CellDrawerSingle = cells_parameters.get_variant(type)
		typed_layers[counter].self_modulate = cell_parameters.cell_color
		counter += 1
	pass
#endregion

#region Field layers
func get_layers_node() -> Node2D:
	if layers_node == null:
		if has_node("layers_node"):
			layers_node = get_node("layers_node")
		else:
			layers_node = Node2D.new()
			layers_node.name = "layers_node"
			add_child(layers_node)
			#if  Engine.is_editor_hint():
				#layers_node.owner = get_tree().edited_scene_root
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
	for i in battlefield_parameters.draw_order.size():
		var layer : TileMapLayer = TileMapLayer.new()
		layers_node.add_child(layer)
		if !tree_exiting.is_connected(layers_node.queue_free):
			tree_exiting.connect(layers_node.queue_free)
		typed_layers.append(layer)
		layer.tile_set = tile_layer.tile_set
		#if  Engine.is_editor_hint():
			#layer.owner = get_tree().edited_scene_root
	pass

func GetLayerByType(type : CellsDrawer.CELL_TYPE) -> TileMapLayer:
	if !battlefield_parameters.draw_order.has(type):
		return null
	var type_position : int = battlefield_parameters.draw_order.find(type)
	return typed_layers[type_position]
	pass

func ClearTypeCells(type: CellsDrawer.CELL_TYPE) -> void:
	var layer : TileMapLayer = GetLayerByType(type)
	cells_displayer.ClearDrawingCellsByType(type)
	if  layer != null:
		layer.clear()
	pass

func ClearAllCellsTypes() -> void:
	cells_displayer.ClearDrawingCells()
	for layer in typed_layers:
		layer.clear()
	pass
#endregion

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

func GetCellPosition(cell : Vector2i) -> Vector2:
	return tile_layer.map_to_local(cell) - position
	pass
