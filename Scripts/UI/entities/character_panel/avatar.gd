@tool
class_name CharacterAvatar
extends MarginContainer

@onready var border_texture: TextureRect = $border/border_texture
@onready var avatar_texture: TextureRect = $avatar_img/avatar_texture

static func get_inject_dependencies() -> Array:
	return [
			#FactorySkillUI,
			#RunConfigsUI,
		]

func inject_dependencies(
		#factory : FactorySkillUI,
		#configs : RunConfigsUI,
	) -> void:
	#skill_ui_factory = factory
	#ui_configs       = configs
	pass
