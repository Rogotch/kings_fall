@abstract
class_name  WarpedSkill
extends     RefCounted

var context_factory : FactorySkillsContext
var status_factory  : FactorySkillsStatus

var skill           : BaseSkill
var skill_status    : SkillStatus
var current_context : SkillContext
var move_system     : BattleMoveSystem

static func get_dependencies() -> Array:
	return 	[
				FactorySkillsContext,
				FactorySkillsStatus,
				BattleMoveSystem,
			]

func _init(
		ctx_factory : FactorySkillsContext,
		sts_factory : FactorySkillsStatus,
		move_sys    : BattleMoveSystem,
		) -> void:
	context_factory = ctx_factory
	status_factory  = sts_factory
	move_system     = move_sys
	pass

@abstract func FocusCell(cell : Vector2i) -> SkillContext
@abstract func EndFocus()                 -> void
@abstract func CanUse(on_cell : Vector2i) -> bool
@abstract func IsActive()                 -> bool
@abstract func InRange(cell : Vector2i)   -> bool

@abstract func get_skill_context(selected_cell : Vector2i) -> SkillContext
#func get_skill_context() -> SkillContext
