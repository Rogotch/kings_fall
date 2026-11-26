@tool
class_name TS_Method
extends TweenStep

@export var method       : Callable
@export var from         : Variant
@export var to           : Variant
@export var time         : float
@export var modificators : Array[TweenMethodModificator]

func modify_tween(tween : Tween) -> Tween:
	var tweener : MethodTweener = tween.tween_method(method, from, to, time)
	for mod in modificators:
		tweener = mod.modify_tween(tweener)
	return tween.chain()
	pass
