@tool
class_name TS_Loops
extends TweenStep

@export var loops_count : int

func modify_tween(tween : Tween) -> Tween:
	return tween.set_loops(loops_count)
	pass
