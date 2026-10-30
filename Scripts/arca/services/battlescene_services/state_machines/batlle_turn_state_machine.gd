class_name BattleStateMachine
extends RefCounted

var input         : InputListener
var initiative    : InitiativeService

var current_state : BattleTurnState

static func get_dependencies() -> Array:
	return [
		InputListener,
		InitiativeService,
		]

func _init(
	input_listener     : InputListener,
	initiative_service : InitiativeService) -> void:
	input      = input_listener
	initiative = initiative_service
	pass

func change_state(new_state : BattleTurnState) -> void:
	
	pass 
