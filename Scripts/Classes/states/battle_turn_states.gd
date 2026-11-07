@abstract
class_name BattleTurnState
extends RefCounted

var battle_state_machine : BattleTurnsSM

func _init(_battle_state_machine : BattleTurnsSM) -> void:
	battle_state_machine = _battle_state_machine
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

class CharacterTurn extends BattleTurnState:
	var character : BaseCharacter
	func _init(_battle_state_machine : BattleTurnsSM, selected_character : BaseCharacter) -> void:
		super._init(_battle_state_machine)
		selected_character = character
		pass
	pass

# TODO StartTurn
class StartTurn     extends CharacterTurn:
	func enter() -> void:
		character.controller.start_turn()
		pass
	pass

# TODO Turn
class Turn          extends CharacterTurn:
	func enter() -> void:
		pass
	pass

# TODO EndTurn
class EndTurn       extends CharacterTurn:
	func enter() -> void:
		character.controller.end_turn()
		pass
	pass

# TODO NewRound
class NewRound      extends BattleTurnState:
	pass
