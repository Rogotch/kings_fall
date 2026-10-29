@icon("uid://dip1kfrrrvl0l")
@tool
extends Node
class_name BattleSceneParameters


@export var field_parameters : FieldDrawerParameters : set = set_field_parameters
@export var cells_parameters : CellsDrawerParameters : set = set_cells_parameters

@export var grid_displayer   : MapDisplayer

func _ready() -> void:
	if Engine.is_editor_hint() && grid_displayer != null:
		set_field_parameters(field_parameters)
		set_cells_parameters(cells_parameters)
		grid_displayer.tool_set_up()
	pass

func set_field_parameters(params : FieldDrawerParameters) -> void:
	#if  field_parameters != null && field_parameters != params:
		#field_parameters.free()
	field_parameters = params
	if grid_displayer != null:
		grid_displayer.field_parameters = field_parameters
	pass

func set_cells_parameters(params : CellsDrawerParameters) -> void:
	#if  cells_parameters != null && cells_parameters != params:
		#cells_parameters.free()
	cells_parameters = params
	if grid_displayer != null:
		grid_displayer.cells_parameters = cells_parameters
	pass
