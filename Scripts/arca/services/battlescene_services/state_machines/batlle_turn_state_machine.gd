class_name BattleTurnsSM
extends RefCounted

var input_sm      : BattleInputSM
var initiative    : InitiativeService
var events        : BattleEvents
var map_displayer : MapDisplayer

var current_state : BattleTurnState

static func get_dependencies() -> Array:
	return [
		BattleInputSM,
		InitiativeService,
		BattleEvents,
		MapDisplayer,
		]

func _init(
		input_listener     : BattleInputSM,
		initiative_service : InitiativeService,
		events_system      : BattleEvents,
		_map_displayer     : MapDisplayer,
	) -> void:
	input_sm      = input_listener
	initiative    = initiative_service
	events        = events_system
	map_displayer = _map_displayer
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

func GetCurrentCharacter() -> BaseCharacter:
	if current_state is not BattleTurnState.CharacterTurn:
		return null
	return current_state.character
	pass
