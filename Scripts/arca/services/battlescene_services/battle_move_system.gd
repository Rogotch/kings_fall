class_name BattleMoveSystem
extends RefCounted

var map           : TileMapLayer

var cells : Dictionary[Vector2i, BaseCharacterController]

static func get_dependencies() -> Array:
	return [BattleScenePathes]

func _init(pathes: BattleScenePathes) -> void:
	map           = pathes.main_map
	pass

func get_map_by_position(position : Vector2i) -> Vector2i:
	return map.local_to_map(position)
	pass

func get_position_by_map(map_cell : Vector2i) -> Vector2:
	return map.map_to_local(map_cell)
	pass

func get_character_by_map(map_cell : Vector2i) -> BaseCharacterController:
	if cells.has(map_cell) && cells[map_cell] != null:
		return cells[map_cell]
	return null
	pass

func set_character_on_cell(character : BaseCharacter, cell : Vector2i) -> void:
	cells[cell] = character.controller
	pass

func change_character_cell(from_cell : Vector2i, to_cell : Vector2i) -> void:
	var character : BaseCharacterController = cells[from_cell]
	cells.erase(from_cell)
	set_character_on_cell(character.body, to_cell)
	pass

func clear_cell(cell : Vector2i) -> void:
	cells.erase(cell)
	pass

#func change_character_cell(cell_from : Vector2i, cell_to : Vector2i) -> void:
	#if !cells.has(cell_from) || cells[cell_from] == null:
		#return
	#var character : BaseCharacterController = cells[cell_from]
	#character.map_position = cell_to
	#pass
