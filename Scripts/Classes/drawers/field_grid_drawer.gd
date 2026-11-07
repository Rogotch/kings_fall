class_name FieldGridDrawer
extends FieldDrawer

var field_grid_params : FieldGridDrawerParameters : 
	get:
		return parameters as FieldGridDrawerParameters
	set(value):
		return

func update_parameters() -> void:
	if parameters == null:
		return
	super.update_parameters()
	calculate_lines(vertical_points, true)
	calculate_lines(horizontal_points, false)
	pass

func draw() -> void:
	if !draw_flag || parameters == null || battlefield_parameters == null:
		return
	draw_lines(vertical_points)
	draw_lines(horizontal_points)
	draw_border()
	pass

func calculate_lines(points_arr : Array, vertical : bool) -> void:
	points_arr.clear()
	var main_axis_vector        : Vector2i = Vector2i.RIGHT if vertical else Vector2i.DOWN
	var secondary_axis_vector   : Vector2i = Vector2i.ONE - main_axis_vector
	var size                    : int = int((battlefield_parameters.field_size * main_axis_vector).length() + 1)
	for i in size:
		var start_cell_position : Vector2  = cell_position_lamda.call(
			i * main_axis_vector
			+ battlefield_parameters.field_start_cell)
		var end_cell_position   : Vector2  = cell_position_lamda.call(
			battlefield_parameters.field_size * secondary_axis_vector
			+ i * main_axis_vector
			+ battlefield_parameters.field_start_cell)
		
		points_arr.append(get_line_points(start_cell_position, field_params.get_cell_size(tile_size_lamda.call()), end_cell_position))
	pass

func get_line_points(start_cell_position : Vector2, cell_size : Vector2i, end_cell_position : Vector2) -> Array[Vector2]:
	return []
	pass

func draw_lines(points_arr : Array) -> void:
	for points : Array[Vector2] in points_arr:
		drawer.draw_line(
			points[0],
			points[1],
			field_grid_params.field_color,
			field_grid_params.field_width,
			field_grid_params.field_antialiased
			)
	pass

func draw_border() -> void:
	var border_points : PackedVector2Array = [
		vertical_points[0][0],
		vertical_points[0][1],
		vertical_points[-1][1], 
		vertical_points[-1][0], 
		vertical_points[0][0]]
	drawer.draw_polyline(
		border_points,
		field_grid_params.field_color,
		field_grid_params.field_width,
		field_grid_params.field_antialiased
		)
	pass
