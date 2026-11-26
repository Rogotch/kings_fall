class_name BattleCharacterPanel
extends HBoxContainer

@export var avatar           : CharacterAvatar
@export var skills_container : SkillsPanel

#var skill_ui_factory : FactorySkillUI
var ui_configs       : RunConfigsUI

static func get_inject_dependencies() -> Array:
	return [
			#FactorySkillUI,
			RunConfigsUI,
		]

func inject_dependencies(
		#factory : FactorySkillUI,
		configs : RunConfigsUI,
	) -> void:
	#skill_ui_factory = factory
	ui_configs       = configs
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
