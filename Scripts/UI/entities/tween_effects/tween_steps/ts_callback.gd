@tool
class_name TS_Callback
extends TweenStep

@export var callback  : Callable
@export var has_delay : bool
@export var delay     : float

func modify_tween(tween : Tween) -> Tween:
	var tweener : CallbackTweener = tween.tween_callback(callback)
	if has_delay:
		tweener.set_delay(delay)
	return tween.chain()
	pass
