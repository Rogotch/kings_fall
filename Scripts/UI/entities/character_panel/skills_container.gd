class_name SkillsPanel
extends MarginContainer

@onready var skills_box: HBoxContainer = $skills/skills_box

static func get_inject_dependencies() -> Array:
	return [
		]
	pass

func inject_dependencies(
		) -> void:
	pass

func SetSkills(skills_manager : SkillsManager) -> void:
	pass

func AddSkill(skill : BaseSkill) -> void:
	pass

func SelectSkill(toggled : bool, index : int) -> void:
	pass

func FocusSkill(index : int) -> void:
	pass
