class_name TargetTypeEmptyCell
extends    TargetTypeBase

func CheckCell(cell : Vector2i, context : SkillContext) -> bool:
	return !context.has_character(cell)
	pass
