@tool
class_name TS_SpeedScale
extends TweenStep

@export var speed : float

func modify_tween(tween : Tween) -> Tween:
	return tween.set_speed_scale(speed)
	pass
