@tool
class_name CellDisplayParameters
extends DrawerParameters

enum CELL_DRAWERS {NONE, PROCEDURAL_CELLS_DRAWER}

@export var cell_color  : Color = Color.CADET_BLUE : set = set_cell_color
@export var cell_drawer : CellDrawerSingle

func set_cell_color(value : Color) -> void:
	cell_color = value
	parameters_changed.emit()
	pass

func set_cell_drawer(new_drawer : CellDrawerSingle) -> void:
	cell_drawer = new_drawer
	notify_property_list_changed()
	parameters_changed.emit()
	pass

func draw_cells_arr(
			drawer    : MapDisplayer, 
			cells_arr : Array[Vector2i],
			type      : CellsDrawer.CELL_TYPE,
			) -> void:
	if cell_drawer == null: return
	cell_drawer.draw_cells_arr(
		drawer,
		self,
		type,
		cells_arr,
	)
	pass
