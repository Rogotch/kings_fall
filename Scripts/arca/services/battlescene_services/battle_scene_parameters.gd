@icon("uid://dip1kfrrrvl0l")
@tool
extends Node
class_name BattleSceneParameters

@export var battle_field_parameters : BattleFieldParameters : set = set_battle_field_parameters
@export var field_drawer_parameters : FieldDrawerParameters : set = set_field_parameters
@export var cells_drawer_parameters : CellsDrawerParameters : set = set_cells_parameters

@export var grid_displayer   : MapDisplayer

func _ready() -> void:
	if Engine.is_editor_hint() && grid_displayer != null:
		set_field_parameters(field_drawer_parameters)
		set_cells_parameters(cells_drawer_parameters)
		set_battle_field_parameters(battle_field_parameters)
		grid_displayer.tool_set_up()
	pass

func set_battle_field_parameters(params : BattleFieldParameters) -> void:
	battle_field_parameters = params
	if grid_displayer != null:
		grid_displayer.battlefield_parameters = battle_field_parameters
	pass

func set_field_parameters(params : FieldDrawerParameters) -> void:
	field_drawer_parameters = params
	if grid_displayer != null:
		grid_displayer.field_parameters = field_drawer_parameters
	pass

func set_cells_parameters(params : CellsDrawerParameters) -> void:
	cells_drawer_parameters = params
	if grid_displayer != null:
		grid_displayer.cells_parameters = cells_drawer_parameters
	pass
