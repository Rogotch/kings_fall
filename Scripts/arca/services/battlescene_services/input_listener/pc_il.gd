class_name PCInputListener
extends InputListener

static func get_dependencies() -> Array:
	return 	[
				BattleScenePathes,
				BattleSceneParameters,
				MapDisplayer,
			]

#func recive_input(event: InputEvent) -> void:
func unhandled_input(event: InputEvent) -> void:
	if !battle_field_parameters.field_has_point(focused_cell):
		return
	if event.is_action("battle_select_cell"):
		select_cell()
	if event.is_action("battle_cancel_action"):
		cancel()
	pass

func physics_tick(delta: float) -> void:
	var  cell : Vector2i = battle_map.local_to_map(battle_map.get_local_mouse_position())
	if   cell != focused_cell && cells_displayer != null:
		focused_cell = cell
		if battle_field_parameters.field_has_point(cell):
			focus_cell(cell)
		else:
			unfocus_cell()
	pass
