@tool
class_name SkillButtonBattle
extends MarginContainer

signal skill_input_toggled(toggled_on: bool)
signal skill_mouse_entered
signal skill_mouse_exited

const MARGIN_TOGGLED_ON  = -2
const MARGIN_TOGGLED_OFF = 0

const COLOR_TOGGLED_ON  := "08080899"
const COLOR_TOGGLED_OFF := "1a1a1a99"

@export var skill_border  : MarginContainer
@export var skill_input   : Button
@export var icon          : TextureRect
@export var button_num    : Label
@export var top_ui        : MarginContainer
@export var background    : Panel

@export_group("Шейдер")
@export
var progress_shader_enabled : bool  : set = set_progress_shader_enabled, get = get_progress_shader_enabled
@export_range(0, 1)
var progress_shader_value   : float : set = set_progress_shader_value,   get = get_progress_shader_value

var background_material : StyleBoxFlat
var shader              : ShaderMaterial
var disabled            : bool
var pressed             : bool

func _ready() -> void:
	shader                  = icon.get_material()
	background_material     = background.get("theme_override_styles/panel")
	progress_shader_enabled = progress_shader_enabled
	progress_shader_value   = progress_shader_value
	set_pressed_visual_status()
	pass

func SetUpByWarpedSkill(skill : WarpedSkill) -> void:
	set_button_icon(skill.skill.icon)
	var progress : float = skill.skill_status.GetCooldownProgressValue()
	progress_shader_enabled = progress < 1
	progress_shader_value   = progress
	pass

func Clear() -> void:
	progress_shader_enabled = false
	progress_shader_value   = 0
	ShowButtonNum(false)
	SetPressedStatus(false)
	icon.texture = null
	pass

func SetPressedStatus(status : bool) -> void:
	pressed = status
	skill_input.button_pressed = status
	set_pressed_visual_status()
	pass

func set_pressed_visual_status() -> void:
	if  background_material != null:
		background_material.bg_color = Color.html(COLOR_TOGGLED_ON if pressed else COLOR_TOGGLED_OFF)
	skill_border.add_theme_constant_override("margin_right",  MARGIN_TOGGLED_ON if pressed else MARGIN_TOGGLED_OFF)
	skill_border.add_theme_constant_override("margin_left",   MARGIN_TOGGLED_ON if pressed else MARGIN_TOGGLED_OFF)
	skill_border.add_theme_constant_override("margin_top",    MARGIN_TOGGLED_ON if pressed else MARGIN_TOGGLED_OFF)
	skill_border.add_theme_constant_override("margin_bottom", MARGIN_TOGGLED_ON if pressed else MARGIN_TOGGLED_OFF)
	pass

func ShowButtonNum(flag : bool) -> void:
	top_ui.visible = flag
	pass

func SetButtonNum(new_num : int) -> void:
	button_num.text = str(new_num)
	pass

func set_button_icon(new_icon : Texture2D) -> void:
	icon.texture = new_icon
	pass

func Disable(flag : bool) -> void:
	skill_input.disabled = flag
	disabled = flag
	pass

#region Shader params
func set_progress_shader_enabled(value : bool) -> void:
	if shader == null:
		return
	progress_shader_enabled = value
	shader.set_shader_parameter("enabled", value)
	pass

func get_progress_shader_enabled() -> bool:
	if shader == null:
		return false
	return shader.get_shader_parameter("enabled")
	pass

func set_progress_shader_value(value : float) -> void:
	if shader == null:
		return
	progress_shader_value = value
	shader.set_shader_parameter("progress", value)
	pass

func get_progress_shader_value() -> float:
	if shader == null:
		return 0
	return shader.get_shader_parameter("progress")
	pass
#endregion

#region Input
func _on_skill_input_toggled(toggled_on: bool) -> void:
	pressed = toggled_on
	set_pressed_visual_status()
	skill_input_toggled.emit(toggled_on)
	pass # Replace with function body.

func _on_skill_input_mouse_entered() -> void:
	skill_mouse_entered.emit()
	pass # Replace with function body.

func _on_skill_input_mouse_exited() -> void:
	skill_mouse_exited.emit()
	pass # Replace with function body.
#endregion
