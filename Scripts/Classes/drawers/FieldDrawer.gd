class_name FieldDrawer
extends Drawer

var field_size         : Vector2i
var field_color        : Color = Color.CORNFLOWER_BLUE
var field_width        : float = 1
var field_antialiased  : bool  = false
var field_start_cell   : Vector2i = Vector2i.ZERO

var   vertical_points  : Array
var horizontal_points  : Array

func inject_dependencies(
		pathes_node      : BattleScenePathes,
		displayer        : MapDisplayer,
		size : Vector2, start : Vector2i = Vector2i.ZERO
		) -> void:
	set_up(pathes_node.main_map, displayer, size, start)
	pass

func set_up(_layer : TileMapLayer, _drawer : Node2D, size : Vector2, start : Vector2i = Vector2i.ZERO) -> void:
	layer            = _layer
	drawer           = _drawer
	cell_size        = cell_size_lamda.call()
	field_start_cell = start
	set_size(size)
	pass

func set_size(new_size : Vector2i) -> void:
	field_size = new_size
	calculate_lines(vertical_points, true)
	calculate_lines(horizontal_points, false)
	pass

func set_start_cell(new_cell : Vector2i) -> void:
	field_start_cell = new_cell
	calculate_lines(vertical_points, true)
	calculate_lines(horizontal_points, false)
	pass

func draw() -> void:
	if !draw_flag:
		return
	draw_lines(vertical_points)
	draw_lines(horizontal_points)
	draw_border()
	pass

func calculate_lines(points_arr : Array, vertical : bool) -> void:
	points_arr.clear()
	var main_axis_vector        : Vector2i = Vector2i.RIGHT if vertical else Vector2i.DOWN
	var secondary_axis_vector   : Vector2i = Vector2i.ONE - main_axis_vector
	var size                    : int = int((field_size * main_axis_vector).length() + 1)
	for i in size:
		var start_cell_position : Vector2  = cell_position_lamda.call(i * main_axis_vector + field_start_cell)
		var end_cell_position   : Vector2  = cell_position_lamda.call(field_size * secondary_axis_vector + i * main_axis_vector + field_start_cell)
		
		points_arr.append(get_line_points(start_cell_position, end_cell_position))
	pass

func get_line_points(start_cell_position : Vector2, end_cell_position : Vector2) -> Array[Vector2]:
	return []
	pass

func draw_lines(points_arr : Array) -> void:
	for points : Array[Vector2] in points_arr:
		drawer.draw_line(points[0], points[1], field_color, field_width, field_antialiased)
	pass

func draw_border() -> void:
	var border_points : PackedVector2Array = [
		vertical_points[0][0],
		vertical_points[0][1],
		vertical_points[-1][1], 
		vertical_points[-1][0], 
		vertical_points[0][0]]
	drawer.draw_polyline(border_points, field_color, field_width, field_antialiased)
	pass
