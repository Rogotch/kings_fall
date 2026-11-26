@tool
class_name CharacterAvatar
extends MarginContainer

@export var border_texture: TextureRect
@export var avatar_texture: TextureRect

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

func SetAvatar(texture : Texture2D) -> void:
	avatar_texture.texture = texture
	pass
