@tool
class_name TS_IgnoreTimeScale
extends TweenStep

@export var flag : bool

func modify_tween(tween : Tween) -> Tween:
	return tween.set_ignore_time_scale(flag)
	pass
