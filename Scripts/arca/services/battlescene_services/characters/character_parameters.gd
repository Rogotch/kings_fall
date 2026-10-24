extends RefCounted
class_name CharacterParameters

var health     : int = 5
var health_max : int = 5
var speed      : int = 3

func setup_by_data(data : CharacterData) -> void:
	health_max = data.max_health
	speed      = data.speed
	health     = health_max
	pass

func hurt(value : int) -> void:
	health -= value
	pass

func death() -> void:
	
	pass
