class_name TargetTypeAlly
extends    TargetTypeCharacter

# TODO Потом переделать на то, чтобы у нас принадлежность определялась не по флагу
func check_character(character : BaseCharacter, context : SkillContext) -> bool:
	return character.controller.is_player == context.owner.controller.is_player
	pass
