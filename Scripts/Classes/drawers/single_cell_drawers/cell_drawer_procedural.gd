@tool
class_name CellDrawerProcedural
extends    CellDrawerSingle

enum DRAW_METHOD  {NONE, FULL, BORDER}

@export var cell_size                : Vector2i       : set = set_cell_size
@export var cell_width               : float = 1      : set = set_cell_width  
@export var cell_antialiased         : bool  = false  : set = set_cell_antialiased      

@export var cell_shape       : CellShape
@export var draw_method      : CellDrawMethod

func set_cell_size(value : Vector2i) -> void:
	cell_size = value
	parameters_changed.emit()
	pass

func set_cell_width(value : float) -> void:
	cell_width = value
	parameters_changed.emit()
	pass

func set_cell_antialiased(value : bool) -> void:
	cell_antialiased = value
	parameters_changed.emit()
	pass

func draw_cell_on_position(
			drawer          : MapDisplayer, 
			cell            : Vector2i,
		) -> void:
	if cell_shape == null || draw_method == null:
		return
	var half_size       : Vector2 = Vector2(cell_size) / 2.0
	var vertexes : PackedVector2Array = cell_shape.get_vertexes(drawer.GetCellPosition(cell), half_size)
	draw_method.draw_cell(drawer, vertexes, self)
	pass
