class_name FieldCellsDrawer
extends FieldDrawer

var cells_drawer : CellsDrawer
var cells        : Array[Vector2i]

var field_cells_params : FieldCellsDrawerParameters : 
	get:
		return parameters as FieldCellsDrawerParameters
	set(value):
		return

static func get_inject_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				MapDisplayer,
			]

func set_up(
		_layer             : TileMapLayer,
		_drawer            : Node2D,
		params             : FieldDrawerParameters,
		battlefield_params : BattleFieldParameters
	) -> void:
	super.set_up(_layer, _drawer, params, battlefield_params)
	pass

func set_parameters(new_parameters : DrawerParameters) -> void:
	super.set_parameters(new_parameters)
	if  cells_drawer != null && new_parameters != null:
		cells_drawer.set_parameters(field_cells_params.cells_parameters)
	pass

func set_up_cells_drawer(new_drawer : CellsDrawer) -> void:
	cells_drawer = new_drawer
	if  cells_drawer != null && field_cells_params != null:
		cells_drawer.set_up(layer, drawer, field_cells_params.cells_parameters, battlefield_parameters)
	update_parameters()
	pass

func update_parameters() -> void:
	if parameters == null:
		return
	super.update_parameters()
	pass

func draw() -> void:
	if !draw_flag || parameters == null || battlefield_parameters == null:
		return
	draw_cells()
	pass

func draw_cells() -> void:
	if cells_drawer == null || battlefield_parameters == null: return
	for     x in battlefield_parameters.field_size.x:
		for y in battlefield_parameters.field_size.y:
			var position : Vector2i = Vector2i(x, y) + battlefield_parameters.field_start_cell
			cells_drawer.draw_cell_on_position(position)
	pass
