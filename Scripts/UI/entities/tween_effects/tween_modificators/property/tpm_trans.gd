@tool
class_name TPM_Trans
extends TweenPropertyModificator

@export var trans : Tween.TransitionType

func modify_tween(property_tweener : PropertyTweener) -> PropertyTweener:
	return property_tweener.set_trans(trans)
	pass
