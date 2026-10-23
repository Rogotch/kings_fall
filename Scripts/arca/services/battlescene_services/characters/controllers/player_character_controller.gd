class_name PlayerCharacterController
extends BaseCharacterController

static func get_dependencies() -> Array:
	return [PCInputListener]

static func get_inject_dependencies() -> Array:
	return []

func _init(input: PCInputListener) -> void:
	super._init(input)
	input.cell_selected.connect(select_cell)
	pass

func select_cell(cell : Vector2i) -> void:
	move_service.move_to_cell(cell)
	pass
