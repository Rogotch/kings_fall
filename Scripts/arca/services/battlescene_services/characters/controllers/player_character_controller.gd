class_name PlayerCharacterController
extends BaseCharacterController

var active : bool = false

static func get_dependencies() -> Array:
	return [CharacterStateMachine]

static func get_inject_dependencies() -> Array:
	return []

func _init(new_state_machine : CharacterStateMachine) -> void:
	super._init(new_state_machine)
	pass

func inject_dependencies(characters_body : BaseCharacter, input : InputListener) -> void:
	body            = characters_body
	body.controller = self
	if input != null:
		input_service   = input
		input_service.cell_selected.connect(select_cell)
	pass

func start_turn() -> void:
	pass

func select_cell(cell : Vector2i) -> void:
	state_machine.select_cell(cell)
	pass
