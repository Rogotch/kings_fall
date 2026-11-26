@tool
class_name TPM_Ease
extends TweenPropertyModificator

@export var ease_type : Tween.EaseType

func modify_tween(property_tweener : PropertyTweener) -> PropertyTweener:
	return property_tweener.set_ease(ease_type)
	pass
