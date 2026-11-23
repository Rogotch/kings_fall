class_name FactorySkillsManagers
extends RefCounted

var container : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func CreateForCharacter(character : BaseCharacter) -> SkillsManagerCharacter:
	var manager : SkillsManagerCharacter = container.resolve(SkillsManagerCharacter)
	container.inject(manager, [character])
	character.skills_manager = manager
	return manager
	pass
	
