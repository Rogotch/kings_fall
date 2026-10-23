class_name BattleCharacterMoveService
extends RefCounted

signal move_started
signal move_ended
signal steped_on_cell(Vector2i)

var MoveSystem   : BattleMoveSystem
var map_position : Vector2i
var body         : BaseCharacter
var speed        : float = 100

static func get_dependencies() -> Array:
	return [BattleMoveSystem]

func _init(move_system: BattleMoveSystem) -> void:
	MoveSystem        = move_system
	pass

static func get_inject_dependencies() -> Array:
	return []

func inject_dependencies(character : BaseCharacter) -> void:
	body              = character
	body.move_service = self
	pass

func place_on_position(new_position : Vector2i) -> void:
	MoveSystem.set_character_on_cell(body, new_position)
	map_position = new_position
	set_body_on_cell(new_position)
	pass

func set_body_on_cell(cell : Vector2i) -> void:
	body.global_position = MoveSystem.get_position_by_map(cell)
	pass

func move_to_cell(to_cell : Vector2i, speed_override : float = speed) -> void:
	move_to_neighbor_cell(map_position, to_cell, speed_override)
	pass

func move_to_neighbor_cell(from_cell : Vector2i, to_cell : Vector2i, speed_override : float = speed) -> void:
	pass

func build_path(from_cell : Vector2i, to_cell : Vector2i) -> Array[Vector2i]:
	return []
	pass
