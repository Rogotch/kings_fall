#@abstract
@tool
class_name CellsDrawerParameters
extends DrawerParameters

@export var base_variant   : CellDrawerSingle :
	set = set_base_variant
@export var cells_variants : Dictionary[CellsDrawer.CELL_TYPE, CellDrawerSingle] :
	set = set_cells_variants

func set_base_variant(
	new_variant : CellDrawerSingle,
	) -> void:
	if  base_variant != null && base_variant != new_variant:
		base_variant.parameters_changed.disconnect(parameters_changed.emit)
	if  base_variant != new_variant:
		base_variant  = new_variant
		if  base_variant != null:
			base_variant.parameters_changed.connect(parameters_changed.emit)
	parameters_changed.emit()
	pass

func set_cells_variants(
		new_variants : Dictionary
		) -> void:
	var deleted_variants : Array[CellDrawerSingle]
	
	for key in cells_variants.keys():
		var cell_params : CellDrawerSingle = cells_variants[key]
		if new_variants.values().has(cell_params):
			continue
		if !deleted_variants.has(cell_params):
			deleted_variants.append(cell_params)

	for deleted_param in deleted_variants:
		if  deleted_param.parameters_changed.is_connected(parameters_changed.emit):
			deleted_param.parameters_changed.disconnect(parameters_changed.emit)
	
	for variant in new_variants.values():
		if !variant.parameters_changed.is_connected(parameters_changed.emit):
			variant.parameters_changed.connect(parameters_changed.emit)
	
	cells_variants = new_variants
	parameters_changed.emit()
	pass

func get_variant(type : CellsDrawer.CELL_TYPE) -> CellDrawerSingle:
	if cells_variants.has(type):
		return cells_variants[type]
	return base_variant
	pass

#func set_base_variant(
	#old_variant : CellDisplayParameters,
	#new_variant : CellDisplayParameters,
	#) -> void:
	#if  old_variant != null && old_variant != new_variant:
		#old_variant.parameters_changed.disconnect(parameters_changed.emit)
	#if  old_variant != new_variant:
		#old_variant  = new_variant
		#if  old_variant != null:
			#old_variant.parameters_changed.connect(parameters_changed.emit)
	#pass
#
#func set_cells_variants(
		#old_variants : Dictionary,
		#new_variants : Dictionary
		#) -> void:
	#var deleted_variants : Array[CellDisplayParameters]
	#
	#for key in old_variants.keys():
		#var cell_params : CellDisplayParameters = old_variants[key]
		#if new_variants.values().has(cell_params):
			#continue
		#if !deleted_variants.has(cell_params):
			#deleted_variants.append(cell_params)
	#
	#for deleted_param in deleted_variants:
		#if  deleted_param.parameters_changed.is_connected(parameters_changed.emit):
			#deleted_param.parameters_changed.disconnect(parameters_changed.emit)
	#
	#for variant in new_variants.values():
		#if !variant.parameters_changed.is_connected(parameters_changed.emit):
			#variant.parameters_changed.connect(parameters_changed.emit)
	#
	#old_variants = new_variants
	#pass
#
#func get_variant(
					#base_variant   : CellDisplayParameters,
					#cells_variants : Dictionary[CellDrawerSingle.CELL_TYPE, CellDisplayParameters],
					#type           : CellDrawerSingle.CELL_TYPE
				#) -> CellDisplayParameters:
	#if cells_variants.has(type):
		#return cells_variants[type]
	#return base_variant
	#pass
