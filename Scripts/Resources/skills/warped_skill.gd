@abstract
class_name  WarpedSkill
extends     RefCounted

var context_factory : FactorySkillsContext
var status_factory  : FactorySkillsStatus

var skill           : BaseSkill
var skill_status    : SkillStatus

static func get_dependencies() -> Array:
	return 	[
				FactorySkillsContext,
				FactorySkillsStatus,
			]

func _init(
		ctx_factory : FactorySkillsContext,
		sts_factory : FactorySkillsStatus,
		) -> void:
	context_factory = ctx_factory
	status_factory  = sts_factory
	pass

@abstract
func get_skill_context() -> SkillContext
