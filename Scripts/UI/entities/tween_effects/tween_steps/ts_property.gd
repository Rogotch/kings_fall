@tool
class_name TS_Property
extends TweenStep

@export var property_name : NodePath
@export var final_value   : Variant
@export var duration      : float

@export var modificators  : Array[TweenPropertyModificator]

func modify_tween(tween : Tween) -> Tween:
	var tweener : PropertyTweener = tween.tween_property(owner, property_name, final_value, duration)
	for mod in modificators:
		tweener = mod.modify_tween(tweener)
	return tween
	pass
