class_name SkillButtonBattle
extends MarginContainer

signal skill_input_toggled(toggled_on: bool)
signal skill_mouse_entered
signal skill_mouse_exited

@onready var skill_border  : MarginContainer = $skill_border
@onready var skill_input   : Button          = $skill_input
@onready var icon          : TextureRect     = $skill_icon/icon

func clear() -> void:
	
	pass

func disable(flag : bool) -> void:
	skill_input.disabled = true
	pass

func _on_skill_input_toggled(toggled_on: bool) -> void:
	skill_input_toggled.emit(toggled_on)
	pass # Replace with function body.

func _on_skill_input_mouse_entered() -> void:
	skill_mouse_entered.emit()
	pass # Replace with function body.

func _on_skill_input_mouse_exited() -> void:
	skill_mouse_exited.emit()
	pass # Replace with function body.
