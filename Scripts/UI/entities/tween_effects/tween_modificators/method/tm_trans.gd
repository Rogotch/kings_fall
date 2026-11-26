@tool
class_name TMM_Trans
extends TweenMethodModificator

@export var trans : Tween.TransitionType

func modify_tween(property_tweener : MethodTweener) -> MethodTweener:
	return property_tweener.set_trans(trans)
	pass
