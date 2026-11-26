@tool
class_name TPM_Dealy
extends TweenPropertyModificator

@export var delay : float

func modify_tween(property_tweener : PropertyTweener) -> PropertyTweener:
	return property_tweener.set_delay(delay)
	pass
