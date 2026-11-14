@icon("uid://dlnwxm4ha3dw2")
class_name BaseSkill
extends Resource

# TODO range - доступная область для проверки активации. Все, с дистанцией, ближние
	# TODO target_type - определяем, какая клетка должна быть, чтобы по ней прошло нажатие
# TODO targeting - какие цели берутся. Приходит клетка, по ней смотрим, кто попадает. Одна клетка, зона, все персонажи
	# TODO area - если у нас таргетинг - область особой формы, то форма зоны ресурсом указывается тут. клетка, круг, линия и тд
	# TODO target_type - модификатор. Указываем, по какому принципу отбираются клетки - только пустые, только персонажи, только враги, только союзники
# TODO mechanics - когда получили все клетки, по которым должна пройти активация, активируем механику неа неё

@export var skill_name  : String
@export var skill_range : SkillRangeBase
@export var targeting   : TargetingBaseSkill
@export var mechanics   : Array[BaseSkillMechanic]

func CanActivate(context : SkillContext) -> bool:
	return skill_range.CanActivate(context)
	pass

func Activate(context : SkillContext) -> void:
	targeting.ModifyContext(context)
	for mechanic in mechanics:
		mechanic.Activate(context)
	pass

#func create_context() -> SkillContext:
	#var context : SkillContext = SkillContext.new()
	#return context
	#pass
