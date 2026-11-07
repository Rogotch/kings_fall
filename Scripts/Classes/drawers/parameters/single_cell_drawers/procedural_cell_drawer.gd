@tool
class_name ProceduralCellDrawer
extends    SingleCellDrawer

enum DRAW_METHOD  {NONE, FULL, BORDER}

@export var cell_shape       : CellShape
@export var draw_method      : CellDrawMethod

func draw_cell_on_position(
			drawer          : Node2D, 
			cell_size       : Vector2i,
			cell_position   : Vector2,
			cell_parameters : CellDisplayParameters
		) -> void:
	if cell_shape == null || draw_method == null:
		return
	var half_size       : Vector2 = Vector2(cell_size) / 2.0
	var vertexes : PackedVector2Array = cell_shape.get_vertexes(cell_position, half_size)
	draw_method.draw_cell(drawer, vertexes, cell_parameters)
	pass
