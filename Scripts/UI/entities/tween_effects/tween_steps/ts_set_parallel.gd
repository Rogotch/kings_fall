@tool
class_name TS_SetParallel
extends TweenStep

@export var flag : bool

func modify_tween(tween : Tween) -> Tween:
	return tween.set_parallel(flag)
	pass
