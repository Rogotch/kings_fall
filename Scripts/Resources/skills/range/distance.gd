class_name SkillRangeDistance
extends    SkillRangeCells

@export var distance : int = 1

func CanActivate(context : SkillContext) -> bool:
	var distance_to_cell : float = context.get_cells_distance_to_activation()
	var parent_check : bool = super.CanActivate(context)
	return distance_to_cell <= distance and parent_check
	pass
