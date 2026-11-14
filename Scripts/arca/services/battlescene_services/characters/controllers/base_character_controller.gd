class_name BaseCharacterController
extends RefCounted

#enum CHARACTER_TEAM     {NONE, OBSTACLE, PLAYER, ALLY, ENEMY}
#enum CHARACTER_RELATION {ANY, OBSTACLE, ALLY, ENEMY}

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
		FactoryCharactersSM,
	]

func inject_dependencies(state_machines_factory : FactoryCharactersSM, characters_body : BaseCharacter) -> void:
	body            = characters_body
	body.controller = self
	create_state_machine(state_machines_factory)
	pass

func create_state_machine(state_machines_factory : FactoryCharactersSM) -> void:
	state_machine = state_machines_factory.Create(body)
	pass

func StartTurn() -> void:
	pass

func EndTurn() -> void:
	pass
