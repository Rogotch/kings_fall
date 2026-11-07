@tool
class_name RectCell
extends CellShape

func get_vertexes(cell_position : Vector2, half_size : Vector2) -> PackedVector2Array:
	return PackedVector2Array([
		cell_position - half_size,
		Vector2(cell_position.x + half_size.x, cell_position.y - half_size.y),
		cell_position + half_size,
		Vector2(cell_position.x - half_size.x, cell_position.y + half_size.y),
		cell_position - half_size,
	])
	pass
