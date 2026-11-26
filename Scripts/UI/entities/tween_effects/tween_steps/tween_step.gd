@abstract
@tool
class_name TweenStep
extends Resource

@abstract
func modify_tween(tween : Tween) -> Tween

var owner : Object

func set_owner(new_owner : Object) -> void:
	owner = new_owner
	pass
