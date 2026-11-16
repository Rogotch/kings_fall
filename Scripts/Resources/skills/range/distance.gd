class_name SkillRangeDistance
extends    SkillRangeCells

@export var max_distance : int = 1
@export var min_distance : int = 0

func CanActivate(context : SkillContext) -> bool:
	var distance_to_cell : float = context.get_cells_distance_to_activation()
	var parent_check : bool = super.CanActivate(context)
	return (distance_to_cell <= max_distance and distance_to_cell > min_distance) and parent_check
	pass
