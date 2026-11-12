class_name BattleInputSM
extends    RefCounted

var current_state : BattleInputStates

var input_service : InputListener
var move_system   : BattleMoveSystem
var displayer     : MapDisplayer

static func get_dependencies() -> Array:
	return [
			InputListener,
			BattleMoveSystem,
			MapDisplayer,
		]

func _init(
		_input_service : InputListener,
		_move_system   : BattleMoveSystem,
		_displayer     : MapDisplayer
	) -> void:
	input_service = _input_service
	move_system   = _move_system
	displayer     = _displayer
	LockInput()
	pass

func change_current_input(new_input_state : BattleInputStates) -> void:
	if  current_state != new_input_state && current_state != null:
		current_state.Exit()
	current_state = new_input_state
	if  current_state != null:
		current_state.Enter()
	pass

func LockInput() -> void:
	change_current_input(BattleInputStates.NoInput.new(input_service, move_system, displayer))
	pass

func Focus() -> void:
	change_current_input(BattleInputStates.InputFocus.new(input_service, move_system, displayer))
	pass

func CharacterFocus(character : BaseCharacter) -> void:
	change_current_input(BattleInputStates.InputCharacterFocus.new(input_service, move_system, displayer, character))
	pass

#func SelectCellSingle() -> void:
	#change_current_input(BattleInputStates.InputSelectCellSingle.new(input_service, move_system, displayer))
	#pass

func SelectCellSingleBase(character : BaseCharacter) -> void:
	change_current_input(BattleInputStates.InputSelectCellSingleBase.new(input_service, move_system, displayer, character))
	pass

#func SelectCellSingleSkill() -> void:
	#change_current_input(BattleInputStates.InputSelectCellSingleSkill.new(input_service, move_system, displayer))
	#pass

#func SelectCellMulti() -> void:
	#pass
