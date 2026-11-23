class_name SkillsManager
extends RefCounted

var factory    : FactoryWarpedSkills

var skills     : Array[WarpedSkill]

static func get_dependencies() -> Array:
	return 	[
				FactoryWarpedSkills,
			]

func _init(
		skills_factory : FactoryWarpedSkills
	) -> void:
	factory = skills_factory
	pass
