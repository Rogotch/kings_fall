@tool
class_name TS_Parallel
extends TweenStep

func modify_tween(tween : Tween) -> Tween:
	return tween.parallel()
	pass
