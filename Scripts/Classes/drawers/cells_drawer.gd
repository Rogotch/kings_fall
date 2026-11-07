class_name CellsDrawer
extends Drawer

enum CELL_TYPE {
		NONE,
		MOVE,
		ATTACK,
	}

var cells_drawer_parameters : CellsDrawerParameters :
	get:
		return parameters as CellsDrawerParameters
	set(value):
		return

var drawing_cells     : Dictionary[CELL_TYPE, Array]

static func get_inject_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				MapDisplayer,
			]

func inject_dependencies(
		pathes_node      : BattleScenePathes,
		displayer        : MapDisplayer,
		params           : CellsDrawerParameters,
		) -> void:
	set_up(pathes_node.main_map, displayer, params)
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

func SetDrawingCells(type : CELL_TYPE, cells : Array[Vector2i]) -> void:
	drawing_cells[type] = cells
	pass

func ClearDrawingCells() -> void:
	drawing_cells.clear()
	pass

func ClearDrawingCellsByType(type : CELL_TYPE) -> void:
	drawing_cells.erase(type)
	pass

func draw() -> void:
	for type in drawing_cells:
		draw_cells_arr(drawing_cells[type], type)
	pass

func draw_cells_arr(arr : Array[Vector2i], type : CELL_TYPE = CELL_TYPE.NONE) -> void:
	for cell in arr:
		draw_cell_on_position(cell, type)
	pass

func draw_cell_on_position(cell : Vector2i, type : CELL_TYPE = CELL_TYPE.NONE) -> void:
	if !draw_flag || cells_drawer_parameters == null || cells_drawer_parameters.get_variant(type) == null:
		return
	var cell_parameters : CellDisplayParameters = cells_drawer_parameters.get_variant(type)
	var cell_position   : Vector2 = cell_position_lamda.call(cell)
	cell_parameters.draw_cell(drawer, tile_size_lamda.call(), cell_position)
	pass
	
