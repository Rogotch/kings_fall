class_name BattleMoveSystem
extends RefCounted

var map           : TileMapLayer
var parameters    : BattleSceneParameters
var pathfinding   : AStarGrid2D

var cells : Dictionary[Vector2i, BaseCharacter]

static func get_dependencies() -> Array:
	return [
		BattleScenePathes,
		BattleSceneParameters
		]

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

func GetAreaCells(start_cell : Vector2i, cost : int, min_cost : int, ignore_solid : bool) -> Array[Vector2i]:
	return Array(get_area_cost_cells(start_cell, cost, min_cost, ignore_solid).keys(), TYPE_VECTOR2I, "", null)
	pass

func get_area_cost_cells(start_cell : Vector2i, cost : int, min_cost : int , ignore_solid : bool) -> Dictionary[Vector2i, int]:
	var reachable_cells : Dictionary[Vector2i, int]
	var frontier : Array[CellStep] = [CellStep.create_step(start_cell, 0)]
	var in_min_cost_cells : Array[Vector2i]
	if min_cost < 0:
		reachable_cells[start_cell] = 0
	
	var directions : Array[Vector2i] = [Vector2i.UP, Vector2i.LEFT, Vector2i.DOWN, Vector2i.RIGHT]
	
	while not frontier.is_empty():
		var current : CellStep = frontier.pop_front()
		for dir in directions:
			var neighbor : Vector2i = current.cell + dir
			if not  pathfinding.region.has_point(neighbor)\
				|| (pathfinding.is_point_solid(neighbor) && !ignore_solid):
				continue
			var cell_cost : int = current.step + 1
			if  cost < cell_cost:
				continue
			if reachable_cells.has(neighbor) && reachable_cells[neighbor] <= cell_cost:
				continue
			if  min_cost >= cell_cost && !in_min_cost_cells.has(neighbor):
				in_min_cost_cells.append(neighbor)
			reachable_cells[neighbor] = cell_cost
			frontier.append(CellStep.create_step(neighbor, cell_cost))
	for cell in in_min_cost_cells:
		reachable_cells.erase(cell)
	return reachable_cells
	pass

class CellStep:
	var cell : Vector2i
	var step : int
	
	static func create_step(new_cell : Vector2i, new_step : int) -> CellStep:
		var new_cell_step : CellStep = CellStep.new()
		new_cell_step.cell = new_cell
		new_cell_step.step = new_step
		return new_cell_step
	
	func _to_string() -> String:
		return "cell %s, cost %s" % [cell, step]
		pass

func get_map_by_position(position : Vector2i) -> Vector2i:
	return map.local_to_map(position)
	pass

func get_position_by_map(map_cell : Vector2i) -> Vector2:
	return map.map_to_local(map_cell)
	pass

func get_character_by_map(map_cell : Vector2i) -> BaseCharacter:
	if cells.has(map_cell) && cells[map_cell] != null:
		return cells[map_cell]
	return null
	pass

func is_cell_free(cell : Vector2i) -> bool:
	return !cells.has(cell) || cells[cell] == null
	pass

func set_character_on_cell(character : BaseCharacter, cell : Vector2i) -> void:
	cells[cell] = character
	pathfinding.set_point_solid(cell, true)
	pass

func erase_character_from_cell(cell : Vector2i) -> void:
	cells.erase(cell)
	pathfinding.set_point_solid(cell, false)
	pass

func change_character_cell(from_cell : Vector2i, to_cell : Vector2i) -> void:
	var character : BaseCharacter = cells[from_cell]
	erase_character_from_cell(from_cell)
	set_character_on_cell(character, to_cell)
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
