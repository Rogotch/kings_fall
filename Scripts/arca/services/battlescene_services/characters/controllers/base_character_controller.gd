class_name BaseCharacterController
extends RefCounted

var body          : BaseCharacter
#var MoveSystem   : BattleMoveSystem
var state_machine : CharacterStateMachine
var move_service  : BattleCharacterMoveService:
	get:
		if body == null:
			return null
		return body.move_service

var is_player : bool = false

static func get_inject_dependencies() -> Array:
	return [
		CharactersSMF,
	]

func inject_dependencies(state_machines_factory : CharactersSMF, characters_body : BaseCharacter) -> void:
	body            = characters_body
	body.controller = self
	create_state_machine(state_machines_factory)
	pass

func create_state_machine(state_machines_factory : CharactersSMF) -> void:
	state_machine = state_machines_factory.create(body)
	pass

func StartTurn() -> void:
	pass

func EndTurn() -> void:
	pass
