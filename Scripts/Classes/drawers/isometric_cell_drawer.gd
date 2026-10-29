class_name IsometricCellDrawer
extends CellsDrawer

static func get_inject_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				MapDisplayer,
			]

func get_vertexes(cell_position : Vector2, half_size : Vector2) -> PackedVector2Array:
	return PackedVector2Array([
		cell_position + Vector2(-half_size.x, 0),
		cell_position + Vector2(0, -half_size.y),
		cell_position + Vector2(half_size.x, 0),
		cell_position + Vector2(0, half_size.y),
		cell_position + Vector2(-half_size.x, 0),
	])
	pass
