class_name DrawersFactory
extends RefCounted

var container   : ArcaContainer
#var parameters  : BattleSceneParameters

enum TYPE_DRAWER {NONE, CELLS, FIELD}
enum CELL_TYPE   {NONE, RECT, ISOMETRIC}
enum FIELD_TYPE  {NONE, GRID, CELLS}

#static func get_inject_dependencies() -> Array:
	#return 	[
				#BattleSceneParameters,
			#]
#
#func inject_dependencies(
		#params      : BattleSceneParameters,
		#) -> void:
	#parameters = params
	#pass

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create(params : DrawerParameters, drawer_type : TYPE_DRAWER, cell_type : CELL_TYPE, field_type : FIELD_TYPE = FIELD_TYPE.NONE) -> Drawer:
	var drawer    : Drawer
	
	match drawer_type:
		TYPE_DRAWER.CELLS:
			drawer = get_cells_drawer_by_type(cell_type, params)
		TYPE_DRAWER.FIELD:
			match field_type:
				FIELD_TYPE.GRID:
					drawer = get_grid_field_drawer_by_type(cell_type, params)
				FIELD_TYPE.CELLS:
					drawer = get_cells_field_drawer_by_type(cell_type, params)
	return drawer
	pass

func get_cells_drawer_by_type(cell_type : CELL_TYPE, params : DrawerParameters) -> CellsDrawer:
	var drawer    : CellsDrawer
	match cell_type:
		CELL_TYPE.RECT:
			drawer = container.resolve(RectCellDrawer)
		CELL_TYPE.ISOMETRIC:
			drawer = container.resolve(IsometricCellDrawer)
	container.inject(drawer, [params])
	return drawer
	pass

func get_grid_field_drawer_by_type(cell_type : CELL_TYPE, params : DrawerParameters) -> FieldDrawer:
	var drawer    : FieldDrawer
	match cell_type:
		CELL_TYPE.RECT:
			drawer = container.resolve(RectFieldGridDrawer)
		CELL_TYPE.ISOMETRIC:
			drawer = container.resolve(IsometricFieldGridDrawer)
	container.inject(drawer, [params])
	return drawer
	pass

func get_cells_field_drawer_by_type(cell_type : CELL_TYPE, params : FieldCellsDrawerParameters) -> FieldCellsDrawer:
	var drawer    : FieldCellsDrawer = container.resolve(FieldCellsDrawer)
	var subdrawer = get_cells_drawer_by_type(cell_type, params.cells_parameters)
	container.inject(drawer, [params])
	drawer.set_up_cells_drawer(subdrawer)
	return drawer
	pass
