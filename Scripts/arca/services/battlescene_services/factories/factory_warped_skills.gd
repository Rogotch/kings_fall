class_name FactorySkillsStatus
extends RefCounted

var container : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(warped_skill : WarpedSkill) -> SkillStatus:
	var context : SkillStatus = container.resolve(SkillStatus)
	container.inject(context, [warped_skill])
	return context
	pass
	
