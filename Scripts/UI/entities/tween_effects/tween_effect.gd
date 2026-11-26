@icon("uid://cidc4b02qc6ej")
@tool
class_name TweenEffect
extends Resource

var owner           : Control
var outter_callable : Callable
var main_tween      : Tween

func set_owner_node(node : Control, callable_func : Callable) -> void:
	owner = node
	outter_callable = callable_func
	pass

func reset() -> void:
	stop_tween()
	outter_callable.call()
	pass

func run_change_round_num() -> void:
	pass

func stop_tween() -> void:
	if  main_tween != null:
		main_tween.stop()
		main_tween.kill()
	pass
