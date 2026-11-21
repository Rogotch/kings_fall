@abstract
class_name PlayerCharacterStates
extends BaseCharacterState

@abstract
class IdlePlayerInput        extends Idle:
	var input_service   : InputListener
	var input_action    : InputAction
	var displayer       : MapDisplayer
	
	var field_displayer : FieldDrawer:
		set(value):
			return
		get:
			return displayer.field_displayer
	
	var cells_displayer : CellsDrawer:
		set(value):
			return
		get:
			return displayer.cells_displayer
	
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter,
			map_displayer   : MapDisplayer,
		) -> void:
		super._init(_state_machine, owner_character)
		displayer = map_displayer
		pass
	
	func Enter()  -> void:
		super.Enter()
		input_service = character.controller.input_service
		set_action()
		connect_action()
		pass
	
	func Exit()   -> void:
		super.Exit()
		disconnect_action()
		pass
	
	func set_action() -> void:
		pass
	
	func connect_action()    -> void:
		input_action.activated.connect(action_activated)
		input_action.canceled.connect(action_canceled)
		pass
	
	func disconnect_action() -> void:
		input_action.activated.disconnect(action_activated)
		input_action.canceled.disconnect(action_canceled)
		pass
	
	func action_activated()  -> void:
		pass
	
	func action_canceled()   -> void:
		pass
	
	func select_cell(cell : Vector2i) -> void:
		pass
	pass

@abstract
class IdleSelectSingleCell   extends IdlePlayerInput:
	var select_cell_action : InputAction.IASelectCell:
		set(value):
			return
		get:
			return input_action as InputAction.IASelectCell
	
	func Exit()   -> void:
		super.Exit()
		cells_displayer.ClearDrawingCells()
		pass
	
	func set_action() -> void:
		input_action = input_service.SelectCell()
		pass
	
	func connect_action()    -> void:
		super.connect_action()
		select_cell_action.cell_focused.connect(focus_cell)
		select_cell_action.cell_unfocused.connect(unfocus_cell)
		pass
	
	func disconnect_action() -> void:
		super.disconnect_action()
		select_cell_action.cell_focused.disconnect(focus_cell)
		select_cell_action.cell_unfocused.disconnect(unfocus_cell)
		pass
	
	func focus_cell(cell : Vector2i) -> void:
		#if MoveSystem.is_cell_free(cell) && MoveSystem.can_move_to_point(character.move_service.map_position, cell):
			#cells_displayer.SetDrawingCells(CellsDrawer.CELL_TYPE.MOVE, Array([cell], TYPE_VECTOR2I, "", null))
			#pass
		pass
	
	func unfocus_cell(cell : Vector2i) -> void:
		cells_displayer.ClearDrawingCellsByType(CellsDrawer.CELL_TYPE.MOVE)
		cells_displayer.ClearDrawingCellsByType(CellsDrawer.CELL_TYPE.ATTACK_SELECTED)
		pass
	pass

class IdleBaseSelect         extends IdleSelectSingleCell:
	func action_activated()  -> void:
		select_cell(select_cell_action.selected_cell)
		pass
	
	func select_cell(cell : Vector2i) -> void:
		#if MoveSystem.is_cell_free(cell) && MoveSystem.can_move_to_point(character.move_service.map_position, cell):
			#state_machine.Move(cell)
		pass
	pass

class IdleSkillSingleSelect  extends IdleSelectSingleCell:
	func Enter()  -> void:
		super.Enter()
		pass
	
	func Exit()   -> void:
		pass
	pass
