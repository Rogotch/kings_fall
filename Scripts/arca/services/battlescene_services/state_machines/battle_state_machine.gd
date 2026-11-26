class_name BattleSM
extends RefCounted

var battle_turns          : BattleTurnsSM
var initiative            : InitiativeService
var characters_controller : AllCharactersController
var events                : BattleEvents

var current_state         : BattleState

static func get_dependencies() -> Array:
	return [
				BattleTurnsSM,
				InitiativeService,
				AllCharactersController,
				BattleEvents,
		]

func _init(
			turns_sm                  : BattleTurnsSM,
			initiative_service        : InitiativeService,
			all_characters_controller : AllCharactersController,
			events_system      : BattleEvents,
	) -> void:
	battle_turns          = turns_sm 
	initiative            = initiative_service
	characters_controller = all_characters_controller
	events                = events_system
	pass


func change_state(new_state : BattleState) -> void:
	if  current_state != null:
		current_state.Exit()
	current_state = new_state
	current_state.Enter()
	pass

func StartBattle() -> void:
	change_state(BattleState.StartBattle.new(self))
	pass

func Battle()      -> void:
	change_state(BattleState.Battle.new(self))
	pass

func Victory()     -> void:
	change_state(BattleState.Victory.new(self))
	pass

func Lose()        -> void:
	change_state(BattleState.Lose.new(self))
	pass
