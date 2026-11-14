class_name MechanicDamage
extends BaseSkillMechanic

@export var damage : int

func Activate(context : SkillContext) -> void:
	for character : BaseCharacter in context.affected_characters:
		var damage_context : DamageContext = create_damage_context(context)
		character.controller.state_machine.Hurt(damage_context)
	pass

func create_damage_context(context : SkillContext) -> DamageContext:
	var new_damage_context : DamageContext = DamageContext.new()
	new_damage_context.value            = damage
	new_damage_context.source_character = context.owner
	return new_damage_context
	pass
