@abstract
class_name SkillRangeBase
extends Resource

func CanActivate(context : SkillContext) -> bool:
	return false
	pass

func GetRangeCells(context : SkillContext) -> Array[Vector2i]:
	return []
	pass
