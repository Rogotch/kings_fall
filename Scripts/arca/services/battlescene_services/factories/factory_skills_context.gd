class_name FactorySkillsContext
extends RefCounted

var container : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(character : BaseCharacter) -> SkillContext:
	var context : SkillContext = container.resolve(SkillContext)
	container.inject(context, [character])
	return context
	pass
	
