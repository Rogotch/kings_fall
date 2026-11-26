@tool
class_name BattleRoundLabel
extends MarginContainer

const BATTLE_START_KEY           : String = "СХВАТКА!"
const ROUND_TEXT_KEY             : String = "РАУНД "
const ROUND_NUM_TEXT_KEY         : String = "%-2s"
const ROUND_NUM_TEXT_SPECIAL_KEY : String = "[color=%s]%-2s[/color]"
#const ROUND_TEXT_KEY         : String = "ROUND %-2s"
#const ROUND_TEXT_SPECIAL_KEY : String = "ROUND [color=%s]%-2s[/color]"

@export var change_num_res : ChangeRoundResource
@export var round_num      : int
@export var special_color  : Color
@export var label          : RichTextLabel
@export var label_num      : RichTextLabel

@export_tool_button("Run")   var button_change_num : Callable = run_change_round_num
@export_tool_button("Reset") var reset_button      : Callable = reset

var events : BattleEvents

static func get_inject_dependencies() -> Array:
	return [
		BattleEvents,
		]

func inject_dependencies(
		events_system      : BattleEvents,
	) -> void:
	events = events_system
	events.round_changed.connect(RunChangeRound)
	pass

func _ready() -> void:
	if  change_num_res != null:
		change_num_res.set_owner_node(self, change_text)
	reset()
	pass

func SetDataBySkill(data : WarpedSkill) -> void:
	#var cooldown_progress : float = data.skill_status.GetCooldownProgressValue()
	
	pass

func reset() -> void:
	round_num = 0
	if  change_num_res != null:
		change_num_res.reset()
	label.text = BATTLE_START_KEY
	label_num.clear()
	pass

func run_change_round_num() -> void:
	round_num += 1
	RunChangeRound(round_num)
	pass

func RunChangeRound(new_num : int) -> void:
	round_num = new_num
	if  change_num_res != null:
		change_num_res.run_change_round_num()
	pass

func change_text() -> void:
	label.text = ROUND_TEXT_KEY
	if round_num >= 5:
		label_num.set_text(ROUND_NUM_TEXT_SPECIAL_KEY % [special_color.to_html(false), round_num])
	else:
		label_num.set_text(ROUND_NUM_TEXT_KEY % round_num)
	pass
