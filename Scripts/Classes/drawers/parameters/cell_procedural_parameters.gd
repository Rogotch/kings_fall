@tool
class_name CellProceduralDisplayParameters
extends CellDisplayParameters

@export var cell_size_overrided      : Vector2i       : set = set_cell_size_overrided
@export var override_cell_size_flag  : bool = true    : set = set_override_cell_size_flag
@export var cell_width               : float = 1      : set = set_cell_width  
@export var cell_antialiased         : bool  = false  : set = set_cell_antialiased      

func set_cell_size_overrided(value : Vector2i) -> void:
	cell_size_overrided = value
	parameters_changed.emit()
	pass

func set_override_cell_size_flag(value : bool) -> void:
	override_cell_size_flag = value
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

func get_cell_size(tile_size : Vector2i) -> Vector2i:
	return cell_size_overrided if override_cell_size_flag else tile_size
	pass
