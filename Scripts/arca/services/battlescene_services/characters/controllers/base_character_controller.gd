class_name BaseCharacterController
extends RefCounted

var body          : BaseCharacter
#var MoveSystem   : BattleMoveSystem
var state_machine : CharacterStateMachine
var input_service : InputListener
var move_service  : BattleCharacterMoveService:
	get:
		if body == null:
			return null
		return body.move_service

static func get_inject_dependencies() -> Array:
	return [
		CharactersSMF,
	]

func inject_dependencies(state_machines_factory : CharactersSMF, characters_body : BaseCharacter, input : InputListener) -> void:
	body            = characters_body
	body.controller = self
	if input != null:
		input_service   = input
	create_state_machine(state_machines_factory)
	pass

func create_state_machine(state_machines_factory : CharactersSMF) -> void:
	state_machine = state_machines_factory.create(body)
	pass

func start_turn() -> void:
	pass

func end_turn() -> void:
	pass
