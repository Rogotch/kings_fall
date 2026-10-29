@tool
class_name FieldDrawerParameters
extends DrawerParameters

@export var field_size         : Vector2i                       : set = set_field_size
@export var field_start_cell   : Vector2i = Vector2i.ZERO       : set = set_field_start_cell

func set_field_size(value : Vector2i) -> void:
	field_size = value
	parameters_changed.emit()
	pass

func set_field_start_cell(value : Vector2i) -> void:
	field_start_cell = value
	parameters_changed.emit()
	pass
