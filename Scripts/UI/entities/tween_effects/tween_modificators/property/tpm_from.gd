@tool
class_name TPM_From
extends TweenPropertyModificator

@export var from_value : Variant

func modify_tween(property_tweener : PropertyTweener) -> PropertyTweener:
	return property_tweener.from(from_value)
	pass
