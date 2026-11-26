@tool
class_name TS_Chained
extends TweenStep

func modify_tween(tween : Tween) -> Tween:
	return tween.chain()
	pass
