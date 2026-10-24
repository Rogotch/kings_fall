class_name BaseCharacterController
extends RefCounted

var body          : BaseCharacter
#var MoveSystem   : BattleMoveSystem
var input_service : PCInputListener
var state_machine : CharacterStateMachine
var move_service  : BattleCharacterMoveService:
	get:
		if body == null:
			return null
		return body.move_service

static func get_dependencies() -> Array:
	return [PCInputListener, CharacterStateMachine]

static func get_inject_dependencies() -> Array:
	return []

func _init(input: PCInputListener, new_state_machine : CharacterStateMachine) -> void:
	input_service = input
	state_machine = new_state_machine
	pass

func inject_dependencies(characters_body : BaseCharacter) -> void:
	body            = characters_body
	body.controller = self
	pass
