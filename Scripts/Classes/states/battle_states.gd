@abstract
class_name BattleState
extends RefCounted

var battle_controller     : BattleSM

var battle_turns          : BattleTurnsSM:
	set(value):
		return null
	get():
		return battle_controller.battle_turns

var initiative            : InitiativeService:
	set(value):
		return null
	get():
		return battle_controller.initiative

var characters_controller : AllCharactersController:
	set(value):
		return null
	get():
		return battle_controller.characters_controller

func _init(
		battle_sm : BattleSM
	) -> void:
	battle_controller = battle_sm
	pass

func Enter() -> void:
	pass

func Exit() -> void:
	pass

# TODO Start Battle
class StartBattle   extends BattleState:
	func Enter() -> void:
		characters_controller.spawn_squads_by_params()
		initiative.BaseSetUpCharactrers(characters_controller.characters_all)
		initiative.UpdateInitiative()
		battle_controller.Battle()
		pass
	pass

# TODO Battle
class Battle        extends BattleState:
	func Enter() -> void:
		battle_turns.NewRound()
		pass
	pass

# TODO Victory
class Victory       extends BattleState:
	pass

# TODO Lose
class Lose          extends BattleState:
	pass
