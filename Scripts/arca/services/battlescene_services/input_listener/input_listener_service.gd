class_name InputListener
extends RefCounted

var battle_map              : TileMapLayer
#var displayer              : MapDisplayer
var cells_displayer         : CellsDrawer
var battle_field_parameters : BattleFieldParameters
var focused_cell            : Vector2i
var focused_character       : BaseCharacter
var input_enabled           : bool = true

var current_input           : InputAction

static func get_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				BattleSceneParameters,
				MapDisplayer,
			]

func _init(
		pathes         : BattleScenePathes,
		parameters     : BattleSceneParameters,
		map_displayer  : MapDisplayer,
		) -> void:
	battle_map              = pathes.main_map
	battle_field_parameters = parameters.battle_field_parameters
	#displayer       = map_displayer
	cells_displayer         = map_displayer.cells_displayer
	pass

func physics_tick(delta: float) -> void:
	var  cell : Vector2i = battle_map.local_to_map(battle_map.get_local_mouse_position())
	if   cell != focused_cell && cells_displayer != null:
		focused_cell = cell
		if battle_field_parameters.field_has_point(cell):
			focus_cell(cell)
		else:
			unfocus_cell()
	pass

#region Cells focus
func RefocusCell() -> void:
	focus_cell(focused_cell)
	pass

func focus_cell(cell : Vector2i) -> void:
	if  current_input != null && current_input is InputAction.IAFocusCell:
		(current_input as InputAction.IAFocusCell).FocusCell(cell)
	pass

func unfocus_cell() -> void:
	if  current_input != null && current_input is InputAction.IAFocusCell:
		(current_input as InputAction.IAFocusCell).UnfocusCell()
	pass

func FocusCell() -> InputAction.IAFocusCell:
	return change_action(InputAction.IAFocusCell.new())
	pass

func SelectCell() -> InputAction.IASelectCell:
	return change_action(InputAction.IASelectCell.new())
	pass
#endregion

#region CHracter focus
func FocusCharacter(character : BaseCharacter) -> void:
	if focused_character != character:
		UnfocusCharacter(focused_character)
	focused_character = character
	if  focused_character != null and focused_character.parameters.IsAlive():
		focus_cell(focused_character.move_service.map_position)
	pass

func UnfocusCharacter(character : BaseCharacter) -> void:
	if focused_character == character:
		focused_character = null
	pass
#endregion

func change_action(new_action : InputAction) -> InputAction:
	if current_input != null && current_input != new_action:
		cancel()
	current_input = new_action
	return current_input
	pass

func select_cell() -> void:
	if !input_enabled || current_input == null:
		return
	#cell_selected.emit(focused_cell)
	current_input.Activate()
	pass

func cancel() -> void:
	if !input_enabled || current_input == null:
		return
	current_input.Cancel()
	pass
