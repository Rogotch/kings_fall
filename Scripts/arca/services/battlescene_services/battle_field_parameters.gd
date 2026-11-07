@tool
class_name BattleFieldParameters
extends Resource

signal parameters_changed

@export var field_size         : Vector2i                       : set = set_field_size
@export var field_start_cell   : Vector2i = Vector2i.ZERO       : set = set_field_start_cell

func field_has_point(point : Vector2i) -> bool:
	return get_filled_rect().has_point(point)
	pass

func get_filled_rect() -> Rect2i:
	return Rect2i(field_start_cell, field_size)
	pass

func set_field_size(value : Vector2i) -> void:
	field_size = value
	parameters_changed.emit()
	pass

func set_field_start_cell(value : Vector2i) -> void:
	field_start_cell = value
	parameters_changed.emit()
	pass
