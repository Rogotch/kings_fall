@tool
class_name TS_Subtween
extends TweenStep

@export var has_delay : bool
@export var delay     : float

func modify_tween(tween : Tween) -> Tween:
	#var tweener : SubtweenTweener = tween.tween_subtween()
	return tween.chain()
	pass
