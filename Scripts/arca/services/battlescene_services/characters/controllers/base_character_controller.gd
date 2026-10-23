class_name BaseCharacterController
extends RefCounted

var body          : BaseCharacter
#var MoveSystem   : BattleMoveSystem
var input_service : PCInputListener
var move_service  : BattleCharacterMoveService:
	get:
		if body == null:
			return null
		return body.move_service

static func get_dependencies() -> Array:
	return [PCInputListener]

static func get_inject_dependencies() -> Array:
	return []

func _init(input: PCInputListener) -> void:
	input_service = input
	pass

func inject_dependencies(characters_body : BaseCharacter) -> void:
	body            = characters_body
	body.controller = self
	pass
