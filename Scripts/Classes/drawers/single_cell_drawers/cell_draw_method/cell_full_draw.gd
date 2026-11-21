@tool
class_name CellFullDraw
extends CellDrawMethod

func draw_cell(
		drawer      : Node2D,
		vertexes    : PackedVector2Array,
		cell_drawer : CellDrawerSingle,
	) -> void:
	drawer.draw_colored_polygon(
			vertexes,
			cell_drawer.cell_color
			)
	pass
