@tool
class_name CellProceduralDisplayParameters
extends CellDisplayParameters

@export var cell_size                : Vector2i       : set = set_cell_size
@export var cell_width               : float = 1      : set = set_cell_width  
@export var cell_antialiased         : bool  = false  : set = set_cell_antialiased      

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

func get_cell_size() -> Vector2i:
	return cell_size
	pass
