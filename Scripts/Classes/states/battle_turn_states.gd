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

var  events              : BattleEvents:
	set(value):
		return
	get():
		return battle_state_machine.events

var  map_displayer       : MapDisplayer:
	set(value):
		return
	get():
		return battle_state_machine.map_displayer

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
	var player_state_machine : CharacterStateMachine:
		get:
			return character.controller.state_machine
		set(value):
			return null
		
	func Enter() -> void:
		super.Enter()
		input_state_machine.SelectCellSingleBase(character)
		player_state_machine.state_changed.connect(character_state_changed)
		pass
		
	func Exit() -> void:
		super.Exit()
		input_state_machine.Focus()
		player_state_machine.state_changed.disconnect(character_state_changed)
		pass
	
	func character_state_changed(new_state : BaseCharacterState) -> void:
		match new_state:
			_ when new_state is BaseCharacterState.Idle:
				map_displayer.ClearAllCellsTypes()
				input_state_machine.SelectCellSingleBase(character)
				input_state_machine.RefocusCell()
			_ when new_state is BaseCharacterState.Attack:
				input_state_machine.Focus()
			_ when new_state is BaseCharacterState.Move:
				input_state_machine.Focus()
		pass
	
	func focus_move_area() -> void:
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
		events.round_changed.emit(initiative.current_num_round)
		run_next_turn()
		pass
	pass
