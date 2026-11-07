@abstract
class_name InputAction
extends RefCounted

signal activated
signal performed
signal canceled

func Activate() -> void:
	activated.emit()
	pass

func Perform() -> void:
	performed.emit()
	pass

func Cancel()  -> void:
	FullCancel()
	pass

func FullCancel()  -> void:
	canceled.emit()
	pass

class IAFocusCell  extends  InputAction:
	signal cell_focused  (cell : Vector2i)
	signal cell_unfocused(cell : Vector2i)
	
	var unfocused    : bool
	var focused_cell : Vector2i
	
	func FocusCell(selected_cell : Vector2i) -> void:
		if focused_cell != selected_cell || unfocused:
			cell_unfocused.emit(focused_cell)
		unfocused = false
		focused_cell = selected_cell
		cell_focused.emit(selected_cell)
		pass
	
	func UnfocusCell() -> void:
		unfocused = true
		cell_unfocused.emit(focused_cell)
		pass
	pass

class IASelectCell extends  IAFocusCell:
	func _init() -> void:
		pass
	pass

class IASingleSelectCell extends  IASelectCell:
	var selected_cell : Vector2i
	
	func Activate() -> void:
		selected_cell = focused_cell
		super.Activate()
		pass
	pass
