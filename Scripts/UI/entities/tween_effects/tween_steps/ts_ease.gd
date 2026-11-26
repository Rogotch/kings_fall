@tool
class_name TS_Ease
extends TweenStep

@export var ease_type : Tween.EaseType

func modify_tween(tween : Tween) -> Tween:
	return tween.set_ease(ease_type)
	pass
