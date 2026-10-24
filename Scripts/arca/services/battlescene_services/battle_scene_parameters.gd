@icon("uid://dip1kfrrrvl0l")
@tool
extends Node
class_name BattleSceneParameters

@export var field_size       : Vector2i : set = set_field_size
@export var field_start_cell : Vector2i : set = set_field_start_cell
@export var grid_displayer   : MapDisplayer

func _ready() -> void:
	if Engine.is_editor_hint() && grid_displayer != null:
		set_field_size(field_size)
		set_field_start_cell(field_start_cell)
		grid_displayer.tool_set_up()
	pass

func set_field_size(new_size : Vector2i) -> void:
	field_size = new_size
	if  grid_displayer != null:
		grid_displayer.set_field_size(new_size)
	pass

func set_field_start_cell(new_cell : Vector2i) -> void:
	field_start_cell = new_cell
	if  grid_displayer != null:
		grid_displayer.set_field_start_cell(new_cell)
	pass
