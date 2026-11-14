class_name  WarpedCharacterSkill
extends     WarpedSkill

var character_owner : BaseCharacter
#var container       : SkillContextFactory
# TODO Получаем из character_data?
	# TODO Skill modificators
	# TODO Skill upgrades
# TODO Skill using statistic?

static func get_dependencies() -> Array:
	return 	[
				FactorySkillsContext,
				FactorySkillsStatus,
			]

static func get_inject_dependencies() -> Array:
	return []

func inject_dependencies(warping_skill : BaseSkill, character : BaseCharacter) -> void:
	skill           = warping_skill
	character_owner = character
	set_up_skill_status()
	pass

func get_skill_context() -> SkillContext:
	var context : SkillContext = context_factory.Create(character_owner)
	return context
	pass

func set_up_skill_status() -> void:
	skill_status = status_factory.Create(self)
	pass
