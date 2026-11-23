@icon("uid://cy2wo3ot2wki6")
extends Node

const GAME_RUN_SCENE = preload("uid://btcitic1iykq6")

@export var session_context : ContextGameSession

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InitRun()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func InitRun() -> void:
	var new_run := GAME_RUN_SCENE.instantiate()
	session_context.add_child(new_run)
	pass
