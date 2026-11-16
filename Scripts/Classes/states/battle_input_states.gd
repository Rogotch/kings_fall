@abstract
class_name BattleInputStates
extends RefCounted

var input_service    : InputListener
var move_system      : BattleMoveSystem
var displayer        : MapDisplayer

var input_action     : InputAction

var cells_displayer  : CellsDrawer:
	set(value):
		return
	get:
		return displayer.cells_displayer

var field_displayer : FieldDrawer:
	set(value):
		return
	get:
		return displayer.field_displayer

func _init(
		_input_service : InputListener,
		_move_system   : BattleMoveSystem,
		_displayer     : MapDisplayer
	) -> void:
	input_service = _input_service
	move_system   = _move_system
	displayer     = _displayer
	pass

func Enter()  -> void:
	set_action()
	connect_action()
	pass

func Exit()   -> void:
	disconnect_action()
	pass

func set_action        ()                              -> void:
	pass

func connect_action    ()                              -> void:
	pass

func disconnect_action ()                              -> void:
	pass

func action_activated  ()                              -> void:
	pass

func action_canceled   ()                              -> void:
	pass

func focus_cell        (cell : Vector2i)               -> void:
	pass

func unfocus_cell      (cell : Vector2i)               -> void:
	pass

func select_cell       (cell : Vector2i)               -> void:
	pass

func focus_character   (new_character : BaseCharacter) -> void:
	pass

func unfocus_character (new_character : BaseCharacter) -> void:
	pass

func select_character  (new_character : BaseCharacter) -> void:
	pass

# No Input
class NoInput                    extends BattleInputStates:
	#func _init() -> void:
		#pass
	func Enter() -> void:
		super.Enter()
		cells_displayer.ClearDrawingCells()
		pass
	pass

# Focus
class InputFocus                 extends BattleInputStates:
	var focus_cell_action : InputAction.IAFocusCell:
		set(value):
			return
		get:
			return input_action as InputAction.IAFocusCell
	
	func set_action() -> void:
		input_action = input_service.FocusCell()
		pass
	
	func connect_action()    -> void:
		super.connect_action()
		focus_cell_action.cell_focused  .connect(focus_cell)
		focus_cell_action.cell_unfocused.connect(unfocus_cell)
		pass
	
	func disconnect_action() -> void:
		super.disconnect_action()
		focus_cell_action.cell_focused  .disconnect(focus_cell)
		focus_cell_action.cell_unfocused.disconnect(unfocus_cell)
		pass
	pass

# Focus
class InputCharacterFocus        extends InputFocus:
	var character       : BaseCharacter
	
	var state_machine  : CharacterStateMachine:
		set(value):
			return
		get:
			return character.controller.state_machine
	
	func _init(
			_input_service     : InputListener,
			_move_system       : BattleMoveSystem,
			_displayer         : MapDisplayer,
			selected_character : BaseCharacter
		) -> void:
		super._init(_input_service, _move_system, _displayer)
		SetCharacter(selected_character)
		pass
	
	func SetCharacter      (new_character : BaseCharacter) -> void:
		character = new_character
		pass
	pass

# Select Cell Single
class InputSelectCellSingle      extends InputCharacterFocus:
	var skills_manager  : SkillsManager:
		set(value):
			return
		get:
			return character.skills_manager
			
	var select_cell_action : InputAction.IASelectCell:
		set(value):
			return
		get:
			return input_action as InputAction.IASelectCell
	
	func set_action() -> void:
		input_action = input_service.SelectCell()
		pass
	
	func connect_action()    -> void:
		super.connect_action()
		input_action.activated    .connect(action_activated)
		input_action.canceled     .connect(action_canceled)
		input_action.cell_selected.connect(select_cell)
		pass
	
	func disconnect_action() -> void:
		super.disconnect_action()
		input_action.activated    .disconnect(action_activated)
		input_action.canceled     .disconnect(action_canceled)
		input_action.cell_selected.disconnect(select_cell)
		pass
	
	func can_use_skill(skill : WarpedCharacterSkill, on_cell : Vector2i) -> bool:
		return skill != null && skill.CanUse(on_cell)
		pass
	
	func can_move_to_cell(to_cell : Vector2i) -> bool:
		return move_system.is_cell_free(to_cell) && move_system.can_move_to_point(character.move_service.map_position, to_cell)
		pass
	pass

# Select Cell Single - Base (Move and attack)
class InputSelectCellSingleBase  extends InputSelectCellSingle:
	func focus_cell(cell : Vector2i)  -> void:
		if   can_use_skill(skills_manager.base_skill, cell):
			var context : SkillContext = skills_manager.base_skill.FocusCell(cell)
			cells_displayer.SetDrawingCells(CellsDrawer.CELL_TYPE.ATTACK, Array(context.focused_cells, TYPE_VECTOR2I, "", null))
		elif can_move_to_cell(cell):
			if  skills_manager.base_skill != null:
				skills_manager.base_skill.EndFocus()
			cells_displayer.SetDrawingCells(CellsDrawer.CELL_TYPE.MOVE, Array([cell], TYPE_VECTOR2I, "", null))
		pass
	
	func unfocus_cell(cell : Vector2i) -> void:
		cells_displayer.ClearDrawingCellsByType(CellsDrawer.CELL_TYPE.MOVE)
		cells_displayer.ClearDrawingCellsByType(CellsDrawer.CELL_TYPE.ATTACK)
		pass
	
	func select_cell(cell : Vector2i) -> void:
		if move_system.is_cell_free(cell) && move_system.can_move_to_point(character.move_service.map_position, cell):
			state_machine.Move(cell)
		pass
	pass

# Select Cell Single - Skill
class InputSelectCellSingleSkill extends InputSelectCellSingle:
	pass

# Select Cell Multi
class InputSelectCellMulti       extends BattleInputStates:
	pass
