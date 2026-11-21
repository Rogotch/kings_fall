@abstract
class_name SkillRangeBase
extends Resource

func CanActivate(context : SkillContext) -> bool:
	return false
	pass

func ModifyContext(context : SkillContext) -> void:
	pass

func GetRangeCells(context : SkillContext) -> Array[Vector2i]:
	ModifyContext(context)
	return context.range_cells
	pass
