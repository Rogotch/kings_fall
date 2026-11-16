class_name TargetingSingleCell 
extends TargetingCells

func get_focused_cells(context : SkillContext) -> Array[Vector2i]:
	return [context.selected_cell]
	pass
