class_name BattleTurnsSM
extends RefCounted

var input_sm      : BattleInputSM
var initiative    : InitiativeService
var round_label   : BattleRoundLabel

var current_state : BattleTurnState

static func get_dependencies() -> Array:
	return [
		BattleInputSM,
		InitiativeService,
		BattleRoundLabel,
		]

func _init(
		input_listener     : BattleInputSM,
		initiative_service : InitiativeService,
		_round_label       : BattleRoundLabel,
	) -> void:
	input_sm    = input_listener
	initiative  = initiative_service
	round_label = _round_label
	pass

func change_state(new_state : BattleTurnState) -> void:
	if  current_state != null:
		current_state.Exit()
	current_state = new_state
	current_state.Enter()
	pass 

func NewTurn() -> void:
	pass

func StartTurn(character : BaseCharacter) -> void:
	var new_turn_state : BattleTurnState.StartTurn = BattleTurnState.StartTurn.new(self, character)
	change_state(new_turn_state)
	pass

func Turn(character : BaseCharacter) -> void:
	var new_turn_state : BattleTurnState.Turn
	if character.controller.is_player:
		new_turn_state = BattleTurnState.PlayerTurn.new(self, character)
	else:
		new_turn_state = BattleTurnState.EnemyTurn .new(self, character)
	change_state(new_turn_state)
	pass

func EndTurn(character : BaseCharacter) -> void:
	var new_turn_state : BattleTurnState.EndTurn   = BattleTurnState.EndTurn.new(self, character)
	change_state(new_turn_state)
	pass

func NewRound() -> void:
	var new_turn_state : BattleTurnState.NewRound  = BattleTurnState.NewRound.new(self)
	change_state(new_turn_state)
	pass
