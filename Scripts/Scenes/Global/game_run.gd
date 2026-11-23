@icon("uid://dj4jpafcjup8j")
extends Node

const BATTLE_SCENE := preload("uid://bpq23qr58akpv")

@export var run_context : ContextGameRun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InitBattleScene()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func InitBattleScene() -> void:
	var new_scene := BATTLE_SCENE.instantiate()
	run_context.add_child(new_scene)
	pass
