@tool
class_name CellBorderDraw
extends CellDrawMethod

func draw_cell(drawer : Node2D, vertexes : PackedVector2Array, parameters : CellDisplayParameters) -> void:
	drawer.draw_polyline(
			vertexes,
			parameters.cell_color,
			parameters.cell_width,
			parameters.cell_antialiased
			)
	pass
