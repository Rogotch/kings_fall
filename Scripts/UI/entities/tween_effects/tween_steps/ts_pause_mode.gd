@tool
class_name TS_SetPauseMod
extends TweenStep

@export var pause_mod : Tween.TweenPauseMode

func modify_tween(tween : Tween) -> Tween:
	tween.set_pause_mode(pause_mod)
	return tween
	pass
