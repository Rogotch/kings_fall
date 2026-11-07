class_name IsometricFieldGridDrawer
extends FieldGridDrawer

static func get_inject_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				MapDisplayer,
			]

func get_line_points(start_cell_position : Vector2, cell_size : Vector2i, end_cell_position : Vector2) -> Array[Vector2]:
	var half_size : Vector2  = Vector2(cell_size) / 2.0
	return [
			start_cell_position - Vector2(0, half_size.y),
			  end_cell_position - Vector2(0, half_size.y)
		]
	pass
