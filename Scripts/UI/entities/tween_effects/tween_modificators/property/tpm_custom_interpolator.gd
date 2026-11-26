@tool
class_name TPM_CustomInterpolator
extends TweenPropertyModificator

@export var curve : Curve

func modify_tween(property_tweener : PropertyTweener) -> PropertyTweener:
	return property_tweener.set_custom_interpolator(curve.sample_baked)
	pass

#func tween_curve(offset : float) -> float:
	#return curve.sample_baked(offset)
	#pass
