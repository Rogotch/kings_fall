extends RefCounted
class_name CharacterParameters

signal character_died

var health     : int = 5
var health_max : int = 5
var speed      : int = 3
var initiative : int = 0
var died       : bool

func SetUpByData(data : CharacterData) -> void:
	health_max = data.max_health
	speed      = data.speed
	health     = health_max
	pass

func Hurt(damage : DamageContext) -> void:
	change_health(-damage.value)
	pass

func Death() -> void:
	health = 0
	died   = true
	character_died.emit()
	pass

func GetSpeed() -> int:
	return speed
	pass

func GetInitiative() -> int:
	return initiative
	pass

func IsAlive() -> bool:
	return health > 0
	pass

func change_health(value : int) -> void:
	health += value
	check_death()
	pass

func check_death() -> void:
	if health <= 0:
		Death()
	pass
