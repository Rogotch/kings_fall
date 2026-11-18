class_name CellsDrawer
extends Drawer

enum CELL_TYPE {
		NONE,
		MOVE,
		MOVE_ZONE,
		ATTACK,
		ATTACK_FOCUS,
		ATTACK_ZONE,
	}

var battlefield_parameters : BattleFieldParameters

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
		pathes_node        : BattleScenePathes,
		displayer          : MapDisplayer,
		battlefield_params : BattleFieldParameters,
		params             : CellsDrawerParameters,
		) -> void:
	set_up(pathes_node.main_map, displayer, battlefield_params, params)
	pass

func set_up(
		_layer             : TileMapLayer, 
		_drawer            : Node2D, 
		battlefield_params : BattleFieldParameters,
		params             : CellsDrawerParameters, 
	) -> void:
	battlefield_parameters = battlefield_params
	parameters             = params
	layer                  = _layer
	drawer                 = _drawer
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
	drawer.ClearTypeLayers()
	pass

func ClearDrawingCellsByType(type : CELL_TYPE) -> void:
	drawing_cells.erase(type)
	drawer.ClearTypeLayer(type)
	pass

func draw() -> void:
	for type in battlefield_parameters.draw_order:
		if !drawing_cells.has(type):
			continue
		draw_cells_arr(drawing_cells[type], type)
	pass

func draw_cells_arr(cells : Array[Vector2i], type : CELL_TYPE = CELL_TYPE.NONE) -> void:
	if !draw_flag || cells_drawer_parameters == null || cells_drawer_parameters.get_variant(type) == null:
		return
	var cell_parameters : CellDisplayParameters = cells_drawer_parameters.get_variant(type)
	cell_parameters.draw_cells_arr(drawer, cells, type)
	pass
	
