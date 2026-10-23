@tool
extends Node

@onready var eight_sided: BaseCharacterVisual = $".."
@onready var main_sprite: Sprite2D = $"../main_sprite"

@export var current_state : BaseCharacterVisual.STATE: 
	set = set_current_state

var enabled : bool = true

func _ready() -> void:
	if !Engine.is_editor_hint():
		enabled = false
	pass

func set_current_state(new_state : BaseCharacterVisual.STATE) -> void:
	if !enabled || eight_sided == null:
		return
	current_state = new_state
	start_animation(new_state)
	pass

#region anims_starters
func start_animation(key : BaseCharacterVisual.STATE) -> void:
	if eight_sided.spritelists.has(key):
		main_sprite.texture = eight_sided.spritelists[key]
	pass
#endregion
