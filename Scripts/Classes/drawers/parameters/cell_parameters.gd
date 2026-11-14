@tool
@abstract
class_name CellDisplayParameters
extends DrawerParameters

enum CELL_DRAWERS {NONE, PROCEDURAL_CELLS_DRAWER}

@export var cell_color  : Color = Color.CADET_BLUE : set = set_cell_color
@export var cell_drawer : SingleCellDrawer

func set_cell_color(value : Color) -> void:
	cell_color = value
	parameters_changed.emit()
	pass

func set_cell_drawer(new_drawer : SingleCellDrawer) -> void:
	cell_drawer = new_drawer
	notify_property_list_changed()
	parameters_changed.emit()
	pass

func draw_cell(
			drawer          : Node2D, 
			tile_size       : Vector2i,
			cell_position   : Vector2,
			) -> void:
	if cell_drawer == null: return
	cell_drawer.draw_cell_on_position(
		drawer,
		get_cell_size(tile_size),
		cell_position,
		self,
	)
	pass
