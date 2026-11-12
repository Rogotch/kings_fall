class_name BattleSM
extends RefCounted

var battle_turns          : BattleTurnsSM
var initiative            : InitiativeService
var characters_controller : AllCharactersController

var current_state         : BattleState

static func get_dependencies() -> Array:
	return [
			BattleTurnsSM,
			InitiativeService,
			AllCharactersController,
		]

func _init(
		input_listener            : BattleTurnsSM,
		initiative_service        : InitiativeService,
		all_characters_controller : AllCharactersController,
	) -> void:
	battle_turns          = input_listener
	initiative            = initiative_service
	characters_controller = all_characters_controller
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
