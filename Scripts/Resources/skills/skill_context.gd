class_name SkillContext
extends Resource

var move_system         : BattleMoveSystem

var owner               : BaseCharacter
var owner_position      : Vector2i

var selected_cell       : Vector2i
var affected_cells      : Array[Vector2i]
var affected_characters : Array[BaseCharacter]

static func get_dependencies() -> Array:
	return 	[
				BattleMoveSystem,
			]

func _init(
		battle_move_system : BattleMoveSystem,
		) -> void:
	move_system = battle_move_system
	pass

func FilterAffectedCells(filter_method : Callable) -> void:
	affected_cells = affected_cells.filter(filter_method)
	pass

func has_character(on_cell : Vector2i) -> bool:
	return !move_system.is_cell_free(on_cell)
	pass

func get_character(on_cell : Vector2i) -> BaseCharacter:
	return move_system.get_character_by_map(on_cell)
	pass

func get_cells_distance_to_activation() -> float:
	return owner_position.distance_to(selected_cell)
	pass
