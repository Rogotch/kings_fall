@abstract
class_name SkillRangeCells
extends    SkillRangeBase

@export var target_type : TargetTypeBase

func CanActivate(context : SkillContext) -> bool:
	return target_type.CheckCell(context.selected_cell, context)
	pass
