class_name CellDrawer
extends Drawer

var cell_color        : Color = Color.CADET_BLUE
var cell_width        : float = 1
var cell_antialiased  : bool  = false
var drawing_cell      : Vector2i

func inject_dependencies(
		pathes_node      : BattleScenePathes,
		displayer        : MapDisplayer,
		) -> void:
	set_up(pathes_node.main_map, displayer)
	pass

func set_up(_layer : TileMapLayer, _drawer : Node2D) -> void:
	layer     = _layer
	drawer    = _drawer
	cell_size = cell_size_lamda.call()
	pass

func draw_cell() -> void:
	if !draw_flag:
		return
	var cell_position : Vector2 = cell_position_lamda.call(drawing_cell)
	var half_size     : Vector2 = Vector2(cell_size) / 2.0
	
	var vertexes = get_vertexes(cell_position, half_size)
	
	drawer.draw_polyline(vertexes, cell_color, cell_width, cell_antialiased)
	pass
	
func get_vertexes(cell_position : Vector2, half_size : Vector2) -> PackedVector2Array:
	return []
	pass
