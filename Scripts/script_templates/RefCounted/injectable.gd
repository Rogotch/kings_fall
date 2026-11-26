#class_name 
extends RefCounted

static func get_inject_dependencies() -> Array:
	return [
		#Dependency,
		]

func inject_dependencies(
		#_dependency : Dependency,
		#_other      : some_class
	) -> void:
	#dependency = _dependency
	#other      = _other
	pass
