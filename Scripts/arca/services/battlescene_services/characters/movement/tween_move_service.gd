class_name TweenMoveService
extends BattleCharacterMoveService

var tween : Tween

static func get_dependencies() -> Array:
	return [BattleMoveSystem]

static func get_inject_dependencies() -> Array:
	return []

func get_time_to_move(from_cell : Vector2i, to_cell : Vector2i, speed_override : float = speed) -> float:
	var start_point  : Vector2 = MoveSystem.get_position_by_map(from_cell)
	var target_point : Vector2 = MoveSystem.get_position_by_map(to_cell)
	var distance     : float   = start_point.distance_to(target_point)
	return distance / speed_override
	pass

#func move_to_cell(to_cell : Vector2i, speed_override : float = speed) -> void:
	#pass

func move_to_neighbor_cell(from_cell : Vector2i, to_cell : Vector2i, speed_override : float = speed) -> void:
	var start_point  : Vector2 = MoveSystem.get_position_by_map(from_cell)
	var target_point : Vector2 = MoveSystem.get_position_by_map(to_cell)
	var time         : float   = get_time_to_move(from_cell, to_cell, speed_override)
	
	if tween != null:
		tween.stop()
		tween.kill()
	
	tween = body.create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(set_body_on_cell.bind(from_cell))
	tween.tween_property(body, "position", target_point, time)
	tween.tween_callback(step_on_cell.bind(to_cell))
	tween.play()
	pass

func step_on_cell(cell : Vector2i) -> void:
	steped_on_cell.emit(cell)
	MoveSystem.change_character_cell(map_position, cell)
	map_position = cell
	pass
