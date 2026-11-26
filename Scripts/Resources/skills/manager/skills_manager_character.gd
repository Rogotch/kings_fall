class_name SkillsManagerCharacter
extends    SkillsManager

var character  : BaseCharacter

var base_skill : WarpedCharacterSkill

static func get_dependencies() -> Array:
	return 	[
				FactoryWarpedSkills,
			]

static func get_inject_dependencies() -> Array:
	return []

func inject_dependencies(owner_character : BaseCharacter) -> void:
	character = owner_character
	pass

func SetUpByCharacterData(data : CharacterData) -> void:
	SetBaseSkill(data.base_skill)
	for skill in data.aviable_skills:
		AddSkill(skill)
	pass

func SetBaseSkill(skill : BaseSkill) -> void:
	if skill == null:
		return
	base_skill = factory.CreateCharacterSkill(skill, character)
	pass

func AddSkill(skill : BaseSkill) -> void:
	skills.append(factory.CreateCharacterSkill(skill, character))
	pass
