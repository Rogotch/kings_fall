@tool
class_name BattleCharacterPanel
extends HBoxContainer

@export var avatar           : CharacterAvatar
@export var skills_container : SkillsPanel
@export var left             : bool = true     : set = set_left_orientation
var bridge          : DataBridgeBattle
var events          : BattleEvents
var ui_configs      : RunConfigsUI

static func get_inject_dependencies() -> Array:
	return [
			DataBridgeBattle,
			BattleEvents,
			RunConfigsUI,
		]

func inject_dependencies(
		s_bridge : DataBridgeBattle,
		b_events : BattleEvents,
		configs  : RunConfigsUI,
	) -> void:
	bridge     = s_bridge
	events     = b_events
	ui_configs = configs
	
	events.player_turn_started.connect(player_turn_started)
	events.player_turn_ended.connect(player_turn_ended)
	pass

func set_left_orientation(value : bool) -> void:
	left = value
	if avatar != null:
		move_child(avatar, 0 if left else 1)
	pass

func player_turn_started() -> void:
	skills_container.visible = true
	var character : BaseCharacter = bridge.GetCurrentCharacter()
	avatar.SetAvatar(character.data.avatar_texture)
	skills_container.set_skills(character.skills_manager)
	pass

func player_turn_ended() -> void:
	skills_container.visible = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skills_container.set_left_orientation(left)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_skills_container_skill_input_toggled(toggled: bool, index: int) -> void:
	if !bridge.HasSkillByIndex(index):
		return
	var skill : WarpedSkill = bridge.GetSkillByIndex(index)
	print("pressed skill %s, %s" % [skill.skill.name_key, toggled])
	pass # Replace with function body.


func _on_skills_container_skill_mouse_entered(index: int) -> void:
	if !bridge.HasSkillByIndex(index):
		return
	var skill : WarpedSkill = bridge.GetSkillByIndex(index)
	print("focused skill %s" % skill.skill.name_key)
	pass # Replace with function body.


func _on_skills_container_skill_mouse_exited(index: int) -> void:
	if !bridge.HasSkillByIndex(index):
		return
	var skill : WarpedSkill = bridge.GetSkillByIndex(index)
	print("unfocused skill %s" % skill.skill.name_key)
	pass # Replace with function body.
