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

static func get_dependencies() -> Array:
	return [CharacterStateMachine]

static func get_inject_dependencies() -> Array:
	return []

func start_turn() -> void:
	pass

func _init(new_state_machine : CharacterStateMachine) -> void:
	state_machine = new_state_machine
	pass

func inject_dependencies(characters_body : BaseCharacter, input : InputListener) -> void:
	body            = characters_body
	body.controller = self
	if input != null:
		input_service   = input
	pass
