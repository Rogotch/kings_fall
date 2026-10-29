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

func move_alongside_path(to_cell : Vector2i, cells_speed : int, speed_override : float = speed) -> void:
	var path : Array[Vector2i] = build_path(map_position, to_cell, cells_speed)
	
	if tween != null:
		tween.stop()
		tween.kill()
	
	tween = body.create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(move_start)
	for i in path.size():
		if path.size() == i + 1:
			break
		var point      : Vector2i = path[i]
		var next_point : Vector2i = path[i + 1]
		set_tween_move_to_cell(tween, point, next_point, speed_override)
	tween.tween_callback(move_end)
	tween.play()
	pass

func set_tween_move_to_cell(set_tween : Tween, from_cell : Vector2i, to_cell : Vector2i, speed_override : float = speed) -> void:
	var start_point  : Vector2 = MoveSystem.get_position_by_map(from_cell)
	var target_point : Vector2 = MoveSystem.get_position_by_map(to_cell)
	var time         : float   = get_time_to_move(from_cell, to_cell, speed_override)
	
	set_tween.tween_callback(set_move_direction.bind(start_point.direction_to(target_point)))
	set_tween.tween_callback(set_body_on_cell.bind(from_cell))
	set_tween.tween_property(body, "position", target_point, time)
	set_tween.tween_callback(step_on_cell.bind(to_cell))
	pass
