@tool
class_name TS_Interval
extends TweenStep

@export var interval : float

func modify_tween(tween : Tween) -> Tween:
	tween.tween_interval(interval)
	return tween
	pass
