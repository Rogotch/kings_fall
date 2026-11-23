class_name FactoryWarpedSkills
extends RefCounted

var container : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func CreateCharacterSkill(original_skill : BaseSkill, character : BaseCharacter) -> WarpedCharacterSkill:
	var skill : WarpedCharacterSkill = container.resolve(WarpedCharacterSkill)
	container.inject(skill, [original_skill, character])
	return skill
	pass
	
