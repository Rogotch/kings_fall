@tool
class_name FieldGridDrawerParameters
extends FieldDrawerParameters

@export var field_color        : Color = Color.CORNFLOWER_BLUE  : set = set_field_color
@export var field_width        : float = 1                      : set = set_field_width
@export var field_antialiased  : bool  = false                  : set = set_field_antialiased

func set_field_color(value : Color) -> void:
	field_color = value
	parameters_changed.emit()
	pass

func set_field_width(value : float) -> void:
	field_width = value
	parameters_changed.emit()
	pass

func set_field_antialiased(value : bool) -> void:
	field_antialiased = value
	parameters_changed.emit()
	pass
