@tool
class_name TS_Await
extends TweenStep

@export var waiting_signal : Signal
@export var has_timeout    : bool
@export var timeout        : float

func modify_tween(tween : Tween) -> Tween:
	var tweener : AwaitTweener = tween.tween_await(waiting_signal)
	if has_timeout:
		tweener.set_timeout(timeout)
	return tween
	pass
