@tool
class_name FieldCellsDrawerParameters
extends FieldDrawerParameters

@export var cells_parameters : CellsDrawerParameters : set = set_cells_parameters

func set_cells_parameters(new_params : CellsDrawerParameters) -> void:
	if  cells_parameters != null && cells_parameters != new_params:
		cells_parameters.parameters_changed.disconnect(parameters_changed.emit)
	if  cells_parameters != new_params:
		cells_parameters  = new_params
		if  cells_parameters != null:
			cells_parameters.parameters_changed.connect(parameters_changed.emit)
	pass
