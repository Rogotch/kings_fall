class_name RectCellDrawer
extends CellDrawer

static func get_inject_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				MapDisplayer
			]

func get_vertexes(cell_position : Vector2, half_size : Vector2) -> PackedVector2Array:
	return PackedVector2Array([
		cell_position - half_size,
		Vector2(cell_position.x + half_size.x, cell_position.y - half_size.y),
		cell_position + half_size,
		Vector2(cell_position.x - half_size.x, cell_position.y + half_size.y),
		cell_position - half_size,
	])
	pass
