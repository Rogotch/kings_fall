@icon("uid://b2q857gtvrjlu")
class_name CharacterData
extends Resource

@export_file_path("*.tscn") var character_scene  : String
@export_file_path("*.tscn") var character_visual : String

@export var max_health     : int
@export var speed          : int
@export var start_position : Vector2i
