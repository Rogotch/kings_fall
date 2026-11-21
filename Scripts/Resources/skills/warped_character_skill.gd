class_name  WarpedCharacterSkill
extends     WarpedSkill

var character_owner : BaseCharacter
#var container       : SkillContextFactory
# TODO Получаем из character_data?
	# TODO Skill modificators
	# TODO Skill upgrades
# TODO Skill using statistic?

static func get_dependencies() -> Array:
	return 	[
				FactorySkillsContext,
				FactorySkillsStatus,
				BattleMoveSystem,
			]

static func get_inject_dependencies() -> Array:
	return []

func inject_dependencies(warping_skill : BaseSkill, character : BaseCharacter) -> void:
	skill           = warping_skill
	character_owner = character
	set_up_skill_status()
	pass

func FocusCell(cell : Vector2i) -> SkillContext:
	if  current_context == null:
		current_context =  get_skill_context(cell)
	current_context.selected_cell = cell
	skill.SetFocusedCells(current_context)
	return current_context
	pass

func EndFocus()   -> void:
	current_context = null
	pass

func CanUse(on_cell : Vector2i) -> bool:
	return IsActive() && InRange(on_cell)
	pass

func IsActive() -> bool:
	return skill_status.IsActive()
	pass

func InRange(cell : Vector2i) -> bool:
	var context : SkillContext = get_skill_context(cell)
	return skill.InRange(context)
	pass

func GetRangeCells(context : SkillContext) -> Array[Vector2i]:
	return skill.GetRangeCells(context)
	pass

func GetPotentialTargets(context : SkillContext) -> Array[Vector2i]:
	return skill.GetPotentialTargets(context)
	pass

func GetFocusedCells(context : SkillContext) -> Array[Vector2i]:
	return skill.GetFocusedCells(context)
	pass

func GetAffectedCells(context : SkillContext) -> Array[Vector2i]:
	return skill.GetAffectedCells(context)
	pass

func get_skill_context(selected_cell : Vector2i) -> SkillContext:
	var context : SkillContext = context_factory.Create(character_owner)
	context.selected_cell = selected_cell
	return context
	pass

func set_up_skill_status() -> void:
	skill_status = status_factory.Create(self)
	pass
