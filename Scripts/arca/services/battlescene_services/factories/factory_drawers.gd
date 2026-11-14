class_name FactoryDrawers
extends RefCounted

var container   : ArcaContainer

enum TYPE_DRAWER {NONE, CELLS, FIELD}
enum FIELD_TYPE  {NONE, GRID, CELLS}

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create_cells_drawer(params : DrawerParameters) -> CellsDrawer:
	var drawer    : CellsDrawer = container.resolve(CellsDrawer) 
	container.inject(drawer, [params])
	return drawer
	pass

func create_field_drawer(
		params             : DrawerParameters,
		battlefield_params : BattleFieldParameters,
		field_type         : FIELD_TYPE = FIELD_TYPE.NONE
		) -> Drawer:
	var drawer    : Drawer
	
	match field_type:
		FIELD_TYPE.GRID:
			drawer = get_grid_field_drawer_by_type(params, battlefield_params)
		FIELD_TYPE.CELLS:
			drawer = get_cells_field_drawer_by_type(params, battlefield_params)
	return drawer
	pass


func get_grid_field_drawer_by_type(
		params             : DrawerParameters,
		battlefield_params : BattleFieldParameters
	) -> FieldGridDrawer:
	var drawer    : FieldGridDrawer = container.resolve(FieldGridDrawer)
	container.inject(drawer, [params, battlefield_params])
	return drawer
	pass

func get_cells_field_drawer_by_type(
		params             : FieldCellsDrawerParameters,
		battlefield_params : BattleFieldParameters
	) -> FieldCellsDrawer:
	var drawer    : FieldCellsDrawer = container.resolve(FieldCellsDrawer)
	var subdrawer = create_cells_drawer(params.cells_parameters)
	container.inject(drawer, [params, battlefield_params])
	drawer.set_up_cells_drawer(subdrawer)
	return drawer
	pass
