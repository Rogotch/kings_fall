@abstract
@tool
class_name CellDrawerSingle
extends Resource

func draw_cell_on_position(
			drawer          : MapDisplayer, 
			cell_parameters : CellDisplayParameters,
			cell            : Vector2i,
		) -> void:
	pass

func draw_cells_arr(
			drawer          : MapDisplayer, 
			cell_parameters : CellDisplayParameters,
			type            : CellsDrawer.CELL_TYPE,
			cells           : Array[Vector2i],
		) -> void:
	for cell in cells:
		draw_cell_on_position(drawer, cell_parameters, cell)
	pass
