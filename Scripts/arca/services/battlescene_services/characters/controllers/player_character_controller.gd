class_name PlayerCharacterController
extends BaseCharacterController

static func get_dependencies() -> Array:
	return [PCInputListener, CharacterStateMachine]

static func get_inject_dependencies() -> Array:
	return []

func _init(input: PCInputListener, new_state_machine : CharacterStateMachine) -> void:
	super._init(input, new_state_machine)
	input.cell_selected.connect(select_cell)
	pass

func select_cell(cell : Vector2i) -> void:
	move_service.move_alongside_path(cell, 3)
	pass
