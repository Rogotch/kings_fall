#class_name Factory
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create() -> Object:
	var controller : Object
	#controller = container.resolve(Object)
	return null
	pass
