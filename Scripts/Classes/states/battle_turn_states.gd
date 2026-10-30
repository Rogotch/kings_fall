@abstract
class_name BattleTurnState
extends RefCounted

func enter() -> void:
	pass

func exit() -> void:
	pass


class CharacterTurn extends BattleTurnState:
	var character : BaseCharacter
	func _init(selected_character : BaseCharacter) -> void:
		selected_character = character
		pass
	pass

# TODO StartTurn
class StartTurn     extends CharacterTurn:
	func enter() -> void:
		character.controller
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
		pass
	pass

# TODO NewRound
class NewRound      extends BattleTurnState:
	pass
