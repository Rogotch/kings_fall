@tool
class_name CellDrawerProcedural
extends    CellDrawerSingle

enum DRAW_METHOD  {NONE, FULL, BORDER}

@export var cell_shape       : CellShape
@export var draw_method      : CellDrawMethod

func draw_cell_on_position(
			drawer          : MapDisplayer, 
			cell_parameters : CellDisplayParameters,
			cell            : Vector2i,
		) -> void:
	if cell_shape == null || draw_method == null:
		return
	var half_size       : Vector2 = Vector2(cell_parameters.get_cell_size()) / 2.0
	var vertexes : PackedVector2Array = cell_shape.get_vertexes(drawer.GetCellPosition(cell), half_size)
	draw_method.draw_cell(drawer, vertexes, cell_parameters)
	pass
