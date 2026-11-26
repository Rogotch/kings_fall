@tool
class_name TS_ProcessMode
extends TweenStep

@export var process_mode : Tween.TweenProcessMode

func modify_tween(tween : Tween) -> Tween:
	tween.set_process_mode(process_mode)
	return tween
	pass
