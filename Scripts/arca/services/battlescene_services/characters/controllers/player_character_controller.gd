class_name PlayerCharacterController
extends BaseCharacterController

var active : bool = false

static func get_inject_dependencies() -> Array:
	return [
		CharactersSMF,
	]

func create_state_machine(state_machines_factory : CharactersSMF) -> void:
	state_machine = state_machines_factory.create_player_sm(body)
	pass

func start_turn() -> void:
	active = true
	pass

func end_turn() -> void:
	active = false
	pass

func recive_input(input_action : InputAction) -> void:
	if !active:
		return
	pass

func select_cell(cell : Vector2i) -> void:
	state_machine.select_cell(cell)
	pass
