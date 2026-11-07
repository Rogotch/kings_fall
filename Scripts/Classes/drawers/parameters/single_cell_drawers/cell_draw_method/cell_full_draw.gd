@tool
class_name CellFullDraw
extends CellDrawMethod

func draw_cell(
			drawer     : Node2D,
			vertexes   : PackedVector2Array,
			parameters : CellDisplayParameters
		) -> void:
	drawer.draw_colored_polygon(
			vertexes,
			parameters.cell_color
			)
	pass
