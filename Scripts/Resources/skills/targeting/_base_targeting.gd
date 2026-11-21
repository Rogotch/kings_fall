@abstract
class_name TargetingBaseSkill
extends Resource

func ModifyContext(context : SkillContext) -> void:
	context.focused_cells = get_focused_cells(context)
	context.affected_cells = get_filtered_affected_cells(context.focused_cells, context)
	context.potential_targets = get_filtered_affected_cells(context.range_cells, context)
	pass

func CheckCell(cell : Vector2i, context : SkillContext) -> bool:
	return false
	pass

func get_focused_cells(context : SkillContext) -> Array[Vector2i]:
	return []
	pass

func get_filtered_affected_cells(cells : Array[Vector2i], context : SkillContext) -> Array[Vector2i]:
	return cells.filter(CheckCell.bind(context))
	pass
