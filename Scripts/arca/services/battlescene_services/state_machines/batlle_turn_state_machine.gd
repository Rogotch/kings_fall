class_name BattleTurnsSM
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
	if  current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	pass 

func StartTurn(character : BaseCharacter) -> void:
	var new_turn_state : BattleTurnState.StartTurn = BattleTurnState.StartTurn.new(self, character)
	change_state(new_turn_state)
	pass

func Turn(character : BaseCharacter) -> void:
	var new_turn_state : BattleTurnState.Turn = BattleTurnState.Turn.new(self, character)
	change_state(new_turn_state)
	pass

func EndTurn(character : BaseCharacter) -> void:
	var new_turn_state : BattleTurnState.EndTurn = BattleTurnState.EndTurn.new(self, character)
	change_state(new_turn_state)
	pass

func NewRound() -> void:
	var new_turn_state : BattleTurnState.NewRound = BattleTurnState.NewRound.new(self)
	change_state(new_turn_state)
	pass
