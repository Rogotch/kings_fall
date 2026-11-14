class_name FactorySkillsManagers
extends RefCounted

var container : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(character : BaseCharacter) -> SkillsManager:
	var manager : SkillsManager = container.resolve(SkillsManager)
	container.inject(manager, [character])
	character.skills_manager = manager
	return manager
	pass
	
