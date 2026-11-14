@abstract
class_name TargetTypeBase
extends Resource

func FilterAffectedCells(context : SkillContext) -> void:
	context.FilterAffectedCells(CheckCell)
	pass

func CheckCell(cell : Vector2i, context : SkillContext) -> bool:
	return false
	pass
