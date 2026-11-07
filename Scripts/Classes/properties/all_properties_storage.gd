@tool
class_name AllPropertiesStorage
extends Resource

@export_storage var properties : Array[PropertyStorage]

func add_all_properties(properties_arr : Array[Dictionary]) -> void:
	for property in properties_arr:
		add_property(property)
	pass

func update_properties(properties_arr : Array[Dictionary]) -> void:
	var missing_properties : Array[String]
	for property in properties_arr:
		if !has_property(property.name):
			missing_properties.append(property.name)
			print_debug("append")
			continue
		change_property(property)
	
	for property_name in missing_properties:
		remove_property(property_name)
	pass

func add_property(property : Dictionary) -> void:
	if !has_property(property.name):
		properties.append(PropertyStorage.create_new(property))
		print_debug("append")
	else:
		change_property(property)
	pass

func remove_property(property_name : StringName) -> void:
	if !has_property(property_name):
		return
	var property : PropertyStorage = get_property(property_name)
	properties.erase(property)
	pass

func change_property(property : Dictionary) -> void:
	var property_res : PropertyStorage = get_property(property.name)
	property_res.set_by_property_dictionary(property)
	pass

func change_property_value(property_name : StringName, value : Variant) -> void:
	if !has_property(property_name):
		return
	var property : PropertyStorage = get_property(property_name)
	property.property_value = value
	pass

func get_property(property_name : StringName) -> PropertyStorage:
	var filtered_properties : Array = properties.filter(
		func(property : PropertyStorage): return property.property_name == property_name)
	return null if filtered_properties.size() == 0 else filtered_properties[0]
	pass

func get_property_value(property_name : StringName) -> Variant:
	var property : PropertyStorage = get_property(property_name)
	return null if property == null else property.property_value
	pass

func has_property(property_name : StringName) -> bool:
	return get_property(property_name) != null
	pass
