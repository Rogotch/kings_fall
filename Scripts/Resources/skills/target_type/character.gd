class_name TargetTypeCharacter
extends    TargetTypeBase

func CheckCell(cell : Vector2i, context : SkillContext) -> bool:
	return context.has_character(cell) && check_character(context.get_character(cell), context)
	pass

func check_character(character : BaseCharacter, context : SkillContext) -> bool:
	return character.parameters.IsAlive()
	pass
