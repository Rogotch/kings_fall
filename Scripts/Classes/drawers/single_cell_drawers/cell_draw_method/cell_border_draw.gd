@tool
class_name CellBorderDraw
extends CellDrawMethod

func draw_cell(
		drawer      : Node2D,
		vertexes    : PackedVector2Array,
		cell_drawer : CellDrawerSingle,
	) -> void:
	drawer.draw_polyline(
			vertexes,
			cell_drawer.cell_color,
			cell_drawer.cell_width,
			cell_drawer.cell_antialiased
			)
	pass
