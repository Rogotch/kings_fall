@abstract
@tool
@icon("uid://krf2ebd3wiqi")
class_name CellDrawerSingle
extends Resource

signal parameters_changed

@export var cell_color  : Color = Color.CADET_BLUE : set = set_cell_color

func set_cell_color(value : Color) -> void:
	cell_color = value
	parameters_changed.emit()
	pass

func draw_cell_on_position(
			drawer          : MapDisplayer, 
			cell            : Vector2i,
		) -> void:
	pass

func draw_cells_arr(
			drawer          : MapDisplayer, 
			type            : CellsDrawer.CELL_TYPE,
			cells           : Array[Vector2i],
		) -> void:
	for cell in cells:
		draw_cell_on_position(drawer, cell)
	pass
