@tool
class_name TMM_Ease
extends TweenMethodModificator

@export var ease_type : Tween.EaseType

func modify_tween(property_tweener : MethodTweener) -> MethodTweener:
	return property_tweener.set_ease(ease_type)
	pass
