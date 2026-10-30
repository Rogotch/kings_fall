@abstract
class_name InputAction
extends RefCounted

func Activate() -> void:
	pass

func Cancel()  -> void:
	pass

class InputSelectCell extends  InputAction:
	var cell : Vector2i
	func _init(selected_cell : Vector2i) -> void:
		cell = selected_cell
		pass
	pass
