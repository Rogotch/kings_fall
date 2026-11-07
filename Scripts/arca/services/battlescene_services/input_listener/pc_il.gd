class_name PCInputListener
extends InputListener

static func get_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				BattleSceneParameters,
				MapDisplayer,
			]

func input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			select_cell()
	pass
