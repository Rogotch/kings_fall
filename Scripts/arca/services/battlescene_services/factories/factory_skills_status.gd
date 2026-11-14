class_name FactoryWarpedSkills
extends RefCounted

var container : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(character : BaseCharacter) -> WarpedCharacterSkill:
	var context : WarpedCharacterSkill = container.resolve(WarpedCharacterSkill)
	return context
	pass
	
