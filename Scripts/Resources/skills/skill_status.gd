class_name SkillStatus
extends RefCounted

var cooldown          : int
var cooldown_progress : int

static func get_inject_dependencies() -> Array:
	return []

func inject_dependencies(skill : WarpedSkill) -> void:
	SetUp(skill)
	pass

func SetUp(warp : WarpedSkill) -> void:
	cooldown = warp.skill.cooldown
	ResetCooldown()
	pass

func IsActive() -> bool:
	return cooldown_progress == 0
	pass

func ResetCooldown() -> void:
	cooldown_progress = 0
	pass

func RunCooldown() -> void:
	cooldown_progress = cooldown
	pass

func CooldownUp() -> void:
	change_cooldown(-1)
	pass

func change_cooldown(value : int) -> void:
	cooldown_progress += value
	pass

func GetCooldownProgressValue() -> float:
	return float(cooldown_progress) / float(cooldown)
	pass
