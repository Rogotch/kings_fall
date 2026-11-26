class_name DataBridgeBattle
extends RefCounted

var turns_system : BattleTurnsSM 

static func get_inject_dependencies() -> Array:
	return [
		BattleTurnsSM,
		]

func inject_dependencies(
		turns_sm : BattleTurnsSM,
	) -> void:
	if turns_sm != null:
		turns_system = turns_sm
	pass
 
func GetCurrentCharacter() -> BaseCharacter:
	var character : BaseCharacter = turns_system.GetCurrentCharacter()
	if character == null:
		push_error("Не смогли получить персонажа")
	return character
	pass
 
func HasSkillByIndex(index : int) -> bool:
	var character : BaseCharacter = GetCurrentCharacter()
	return character.skills_manager.skills.size() > index
	pass

func GetSkillByIndex(index : int) -> WarpedSkill:
	var character : BaseCharacter = GetCurrentCharacter()
	return character.skills_manager.skills[index]
	pass
