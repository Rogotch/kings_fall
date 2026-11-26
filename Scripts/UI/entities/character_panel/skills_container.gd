class_name SkillsPanel
extends MarginContainer

signal skill_input_toggled(toggled : bool, index : int)
signal skill_mouse_entered(index : int)
signal skill_mouse_exited(index : int)

@export var skills_box : HBoxContainer
var skill_ui_factory   : FactorySkillUI
var ui_configs         : RunConfigsUI
var skill_buttons      : Array[SkillButtonBattle]
var left               : bool 

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

func set_left_orientation(flag : bool) -> void:
	left = true
	pass

func load_skill_buttons() -> void:
	for i in ui_configs.battle_skills_buttons_in_panel:
		add_skill_button(i)
	pass

func set_skills(skills_manager : SkillsManager) -> void:
	for i in ui_configs.battle_skills_buttons_in_panel:
		var button : SkillButtonBattle = skill_buttons[i]
		var skill_index : int = get_skill_index(i)
		if !skills_manager.skills.size() > skill_index:
			button.Clear()
			button.Disable(true)
			button.ShowButtonNum(false)
			continue
		button.Disable(false)
		var skill : WarpedSkill = skills_manager.skills[skill_index]
		button.ShowButtonNum(true)
		button.SetButtonNum(skill_index + 1)
		button.SetUpByWarpedSkill(skill)
	pass

func add_skill_button(index : int) -> SkillButtonBattle:
	var skill_button : SkillButtonBattle = skill_ui_factory.CreateButton()
	skill_button.skill_input_toggled.connect(select_skill.bind(index))
	skill_button.skill_mouse_entered.connect(focus_skill.bind(index))
	skill_button.skill_mouse_exited.connect(unfocus_skill.bind(index))
	skills_box.add_child(skill_button)
	skill_buttons.append(skill_button)
	skill_button.Clear()
	return skill_button
	pass

func select_skill(toggled : bool, index : int) -> void:
	skill_input_toggled.emit(toggled, get_skill_index(index))
	pass

func focus_skill(index : int) -> void:
	skill_mouse_entered.emit(get_skill_index(index))
	pass

func unfocus_skill(index : int) -> void:
	skill_mouse_exited.emit(get_skill_index(index))
	pass

func get_skill_index(index : int) -> int:
	return index if left else ui_configs.battle_skills_buttons_in_panel - 1 - index
	pass 
