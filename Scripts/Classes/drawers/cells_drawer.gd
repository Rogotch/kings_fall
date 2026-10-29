class_name CellsDrawer
extends Drawer

var cell_parameters : CellsDrawerParameters :
	get:
		return parameters as CellsDrawerParameters
	set(value):
		return

var drawing_cell      : Vector2i

func inject_dependencies(
		pathes_node      : BattleScenePathes,
		displayer        : MapDisplayer,
		params           : CellsDrawerParameters,
		) -> void:
	set_up(pathes_node.main_map, displayer, params)
	pass

func get_cell_size() -> Vector2i:
	return      (cell_parameters.cell_size_overrided
			if   cell_parameters != null && cell_parameters.override_cell_size_flag 
			else layer.tile_set.tile_size)
	pass
	
func set_up(_layer : TileMapLayer, _drawer : Node2D, params : CellsDrawerParameters) -> void:
	parameters = params
	layer      = _layer
	drawer     = _drawer
	update_parameters()
	pass

func update_parameters() -> void:
	super.update_parameters()
	pass

func draw_cell() -> void:
	draw_cell_on_position(drawing_cell)
	pass

func draw_cells_arr(arr : Array[Vector2i]) -> void:
	for cell in arr:
		draw_cell_on_position(cell)
	pass

func draw_cell_on_position(cell : Vector2i) -> void:
	if !draw_flag:
		return
	var cell_position : Vector2 = cell_position_lamda.call(cell)
	var half_size     : Vector2 = Vector2(cell_size) / 2.0
	
	var vertexes = get_vertexes(cell_position, half_size)
	
	drawer.draw_polyline(vertexes, cell_parameters.cell_color, cell_parameters.cell_width, cell_parameters.cell_antialiased)
	pass
	
func get_vertexes(cell_position : Vector2, half_size : Vector2) -> PackedVector2Array:
	return []
	pass
