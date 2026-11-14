class_name SkillsManager
extends RefCounted

var factory    : FactoryWarpedSkills
var character  : BaseCharacter

var base_skill : BaseSkill

static func get_dependencies() -> Array:
	return 	[
				FactoryWarpedSkills,
			]

func _init(
		skills_factory : FactoryWarpedSkills
	) -> void:
	factory = skills_factory
	pass

static func get_inject_dependencies() -> Array:
	return []

func inject_dependencies(owner_character : BaseCharacter) -> void:
	character = owner_character
	pass

func AddSkill(skill : BaseSkill) -> void:
	
	pass
