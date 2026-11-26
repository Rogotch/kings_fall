class_name SkillsPanel
extends MarginContainer

@export var skills_box: HBoxContainer
var skill_ui_factory : FactorySkillUI
var ui_configs       : RunConfigsUI
var skill_buttons    : Array[SkillButtonBattle]

static func get_inject_dependencies() -> Array:
	return [
		FactorySkillUI,
		RunConfigsUI,
		]

func inject_dependencies(
		factory : FactorySkillUI,
		configs : RunConfigsUI,
	) -> void:
	skill_ui_factory = factory
	ui_configs       = configs
	load_skill_buttons()
	pass

func load_skill_buttons() -> void:
	for i in ui_configs.battle_skills_buttons_in_panel:
		add_skill_button(i)
	pass

func set_skills(skills_manager : SkillsManager) -> void:
	for button in skill_buttons:
		button.visible = false
	for skill in skills_manager.skills.size():
		var button : SkillButtonBattle
	pass

func get_skill_button() -> void:
	
	pass

func add_skill_button(index : int) -> SkillButtonBattle:
	var skill_button : SkillButtonBattle = skill_ui_factory.CreateButton()
	skill_button.skill_input_toggled.connect(select_skill.bind(index))
	skill_button.skill_mouse_entered.connect(focus_skill.bind(index))
	skill_button.skill_mouse_exited.connect(unfocus_skill.bind(index))
	skills_box.add_child(skill_button)
	skill_buttons.append(skill_button)
	return skill_button
	pass

func select_skill(toggled : bool, index : int) -> void:
	pass

func focus_skill(index : int) -> void:
	pass

func unfocus_skill(index : int) -> void:
	pass
