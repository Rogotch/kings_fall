class_name BattleMoveSystem
extends RefCounted

var map           : TileMapLayer
var parameters    : BattleSceneParameters
var pathfinding   : AStarGrid2D

var cells : Dictionary[Vector2i, BaseCharacterController]

static func get_dependencies() -> Array:
	return [BattleScenePathes, BattleSceneParameters]

func _init(pathes: BattleScenePathes, new_params : BattleSceneParameters) -> void:
	map           = pathes.main_map
	parameters    = new_params
	set_up_pathfinding()
	pass

func set_up_pathfinding() -> void:
	pathfinding = AStarGrid2D.new()
	pathfinding.cell_shape                = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN
	pathfinding.cell_size                 = map.tile_set.tile_size
	pathfinding.region                    = parameters.battle_field_parameters.get_filled_rect()
	
	pathfinding.diagonal_mode             = AStarGrid2D.DIAGONAL_MODE_NEVER
	pathfinding.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	pathfinding.update()
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

func is_cell_free(cell : Vector2i) -> bool:
	return !cells.has(cell) || cells[cell] == null
	pass

func set_character_on_cell(character : BaseCharacter, cell : Vector2i) -> void:
	cells[cell] = character.controller
	pathfinding.set_point_solid(cell, true)
	pass

func erase_character_from_cell(cell : Vector2i) -> void:
	cells.erase(cell)
	pathfinding.set_point_solid(cell, false)
	pass

func change_character_cell(from_cell : Vector2i, to_cell : Vector2i) -> void:
	var character : BaseCharacterController = cells[from_cell]
	erase_character_from_cell(from_cell)
	set_character_on_cell(character.body, to_cell)
	pass

func can_move_to_point(from_cell : Vector2i, to_cell : Vector2i) -> bool:
	if !pathfinding.is_in_boundsv(from_cell) || !pathfinding.is_in_boundsv(to_cell):
		return false
	return get_path(from_cell, to_cell).size() > 0
	pass

func get_path(from_cell : Vector2i, to_cell : Vector2i) -> Array[Vector2i]:
	pathfinding.set_point_solid(from_cell, false)
	var path : Array[Vector2i] = pathfinding.get_id_path(from_cell, to_cell)
	pathfinding.set_point_solid(from_cell, true)
	return path
	pass

func get_path_by_speed(from_cell : Vector2i, to_cell : Vector2i, speed : int) -> Array[Vector2i]:
	var path : Array[Vector2i] = get_path(from_cell, to_cell)
	if path.size() <= speed + 1:
		return path
	else:
		return path.slice(0, speed + 1)
	pass

#func change_character_cell(cell_from : Vector2i, cell_to : Vector2i) -> void:
	#if !cells.has(cell_from) || cells[cell_from] == null:
		#return
	#var character : BaseCharacterController = cells[cell_from]
	#character.map_position = cell_to
	#pass
