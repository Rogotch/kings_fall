extends Node
@export var context_ui: ContextUI

const BATTLE_INTERFACE = preload("uid://cx262tev6qwf0")

func _ready() -> void:
	init_interface()
	pass

func init_interface() -> void:
	var interface : BattleInterface = BATTLE_INTERFACE.instantiate()
	context_ui.add_child(interface)
	pass
