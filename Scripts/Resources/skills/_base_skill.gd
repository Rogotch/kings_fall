@icon("uid://dlnwxm4ha3dw2")
class_name BaseSkill
extends Resource

# TODO range - доступная область для проверки активации. Все, с дистанцией, ближние
	# TODO target_type - определяем, какая клетка должна быть, чтобы по ней прошло нажатие
# TODO targeting - какие цели берутся. Приходит клетка, по ней смотрим, кто попадает. Одна клетка, зона, все персонажи
	# TODO area - если у нас таргетинг - область особой формы, то форма зоны ресурсом указывается тут. клетка, круг, линия и тд
	# TODO target_type - модификатор. Указываем, по какому принципу отбираются клетки - только пустые, только персонажи, только враги, только союзники
# TODO mechanics - когда получили все клетки, по которым должна пройти активация, активируем механику неа неё

@export var skill_name          : String
@export var cooldown            : int
@export var skill_use_animation : BaseCharacterVisual.ANIMATION_STATE
@export var skill_range         : SkillRangeBase
@export var targeting           : TargetingBaseSkill
@export var mechanics           : Array[BaseSkillMechanic]

func Activate(context : SkillContext) -> void:
	for mechanic in mechanics:
		mechanic.Activate(context)
	pass

func InRange(context : SkillContext) -> bool:
	return skill_range.CanActivate(context)
	pass

func GetRangeCells(context : SkillContext) -> Array[Vector2i]:
	return skill_range.GetRangeCells(context)
	pass

func GetPotentialTargets(context : SkillContext) -> Array[Vector2i]:
	skill_range.ModifyContext(context)
	SetFocusedCells(context)
	return context.potential_targets
	pass

func GetFocusedCells(context : SkillContext) -> Array[Vector2i]:
	SetFocusedCells(context)
	return context.focused_cells
	pass

func GetAffectedCells(context : SkillContext) -> Array[Vector2i]:
	SetFocusedCells(context)
	return context.affected_cells
	pass

func SetFocusedCells(context : SkillContext) -> void:
	targeting.ModifyContext(context)
	pass


#func create_context() -> SkillContext:
	#var context : SkillContext = SkillContext.new()
	#return context
	#pass
