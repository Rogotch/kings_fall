class_name BattleCharacterMoveService
extends RefCounted

signal move_started
signal move_ended
signal steped_on_cell(Vector2i)

var MoveSystem   : BattleMoveSystem
var map_position : Vector2i
var body         : BaseCharacter
var speed        : float = 40

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

func move_alongside_path(to_cell : Vector2i, cells_speed : int, speed_override : float = speed) -> void:
	var path : Array[Vector2i] = build_path(map_position, to_cell, cells_speed)
	
	pass

func build_path(from_cell : Vector2i, to_cell : Vector2i, cells_speed : int) -> Array[Vector2i]:
	return MoveSystem.get_path_by_speed(from_cell, to_cell, cells_speed)
	pass

func step_on_cell(cell : Vector2i) -> void:
	steped_on_cell.emit(cell)
	MoveSystem.change_character_cell(map_position, cell)
	map_position = cell
	pass

func move_start() -> void:
	move_started.emit()
	pass

func move_end() -> void:
	move_ended.emit()
	pass

func set_move_direction(direction : Vector2) -> void:
	body.visual.SetDirection(direction)
	pass
