@abstract
class_name BattleTurnState
extends RefCounted

var battle_state_machine : BattleTurnsSM

var  input_state_machine : BattleInputSM:
	set(value):
		return
	get():
		return battle_state_machine.input_sm

var  initiative          : InitiativeService:
	set(value):
		return
	get():
		return battle_state_machine.initiative

var  round_label         : BattleRoundLabel:
	set(value):
		return
	get():
		return battle_state_machine.round_label

func _init(
		battle_turns     : BattleTurnsSM
	) -> void:
	battle_state_machine = battle_turns
	pass

func Enter() -> void:
	pass

func Exit() -> void:
	pass

func run_next_turn() -> void:
	var first_character : BaseCharacter = initiative.NextCharacter()
	battle_state_machine.StartTurn(first_character)
	pass

class CharacterTurn extends BattleTurnState:
	var character : BaseCharacter
	
	func _init(
		battle_turns       : BattleTurnsSM,
		selected_character : BaseCharacter
		) -> void:
		super._init(battle_turns)
		character = selected_character
		pass
	pass

# TODO StartTurn
class StartTurn  extends CharacterTurn:
	func Enter() -> void:
		character.controller.StartTurn()
		battle_state_machine.Turn(character)
		pass
	pass

# TODO Turn
class Turn       extends CharacterTurn:
	func Enter() -> void:
		pass
	pass

class PlayerTurn extends Turn:
	func Enter() -> void:
		super.Enter()
		input_state_machine.SelectCellSingleBase(character)
		pass
		
	func Exit() -> void:
		super.Exit()
		input_state_machine.Focus()
		pass
	pass

class EnemyTurn  extends Turn:
	func Enter() -> void:
		super.Enter()
		battle_state_machine.EndTurn(character)
		pass
	pass

# TODO EndTurn
class EndTurn   extends CharacterTurn:
	func Enter() -> void:
		super.Enter()
		character.controller.EndTurn()
		if initiative.HasLefRoundCharacters():
			run_next_turn()
		else:
			battle_state_machine.NewRound()
		pass
	pass

# TODO NewRound
class NewRound  extends BattleTurnState:
	func Enter() -> void:
		super.Enter()
		initiative.NewRound()
		round_label.RunChangeRound(initiative.current_num_round)
		run_next_turn()
		pass
	pass
