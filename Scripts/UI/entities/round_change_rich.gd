@tool
class_name BattleRoundLabel
extends RichTextLabel

const BATTLE_START_KEY       : String = "СХВАТКА!"
const ROUND_TEXT_KEY         : String = "РАУНД %-2s"
const ROUND_TEXT_SPECIAL_KEY : String = "РАУНД [color=%s]%-2s[/color]"
#const ROUND_TEXT_KEY         : String = "ROUND %-2s"
#const ROUND_TEXT_SPECIAL_KEY : String = "ROUND [color=%s]%-2s[/color]"

@export var change_num_res : ChangeRoundResource
@export var round_num : int
@export var special_color : Color
@export_tool_button("Run")   var button_change_num : Callable = run_change_round_num
@export_tool_button("Reset") var reset_button      : Callable = reset

func _ready() -> void:
	if  change_num_res != null:
		change_num_res.set_owner_node(self, change_text)
	reset()
	pass

func reset() -> void:
	round_num = 0
	if  change_num_res != null:
		change_num_res.reset()
	text = BATTLE_START_KEY
	pass

func run_change_round_num() -> void:
	round_num += 1
	RunChangeRound(round_num)
	pass

func RunChangeRound(new_num : int) -> void:
	if  change_num_res != null:
		change_num_res.run_change_round_num(new_num)
	pass

func change_text(new_num : int) -> void:
	if new_num >= 5:
		text = ROUND_TEXT_SPECIAL_KEY % [special_color.to_html(false), new_num]
	else:
		text = ROUND_TEXT_KEY % new_num
	pass
