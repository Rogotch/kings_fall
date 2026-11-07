class_name GlobalMethods
extends RefCounted

static func get_enum_line_from_keys_arr(keys_arr : Array) -> String:
	var keys : Array[String] = Array(keys_arr, TYPE_STRING, "", null)
	var final_line : String = ""
	for key in keys:
		if !final_line.is_empty():
			final_line += ","
		final_line += key
	return final_line
	pass

#func update_properties_storage(old_properties : Array[Dictionary], new_properties : Array[Dictionary]) -> void:
	##for property in old_properties:
		##var has_property : bool = 
	#pass
