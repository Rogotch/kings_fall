@abstract
class_name TargetingCells
extends    TargetingBaseSkill

@export var target_type : TargetTypeBase

func CheckCell(cell : Vector2i, context : SkillContext) -> bool:
	if target_type == null:
		return true
	return target_type.CheckCell(cell, context)
	pass
