@tool
class_name TMM_Dealy
extends TweenMethodModificator

@export var delay : float

func modify_tween(property_tweener : MethodTweener) -> MethodTweener:
	return property_tweener.set_delay(delay)
	pass
