@tool
class_name PropertyStorage
extends Resource

@export_storage var property_name        : StringName
@export_storage var property_type        : Variant.Type
@export_storage var property_class_name  : StringName
@export_storage var property_hint        : PropertyHint
@export_storage var property_hint_string : String
@export_storage var property_usage       : PropertyUsageFlags
@export_storage var property_value       : Variant

static func create_new(dict : Dictionary) -> PropertyStorage:
	var property : PropertyStorage = PropertyStorage.new()
	property.set_by_property_dictionary(dict)
	return property
	pass

func set_by_property_dictionary(dict : Dictionary) -> void:
	for key in dict.keys():
		set("property_" + key, dict[key])
	pass
