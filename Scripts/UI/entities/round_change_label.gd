@tool
extends Label

const ROUND_TEXT_KEY : String = "Round %-2s"

@export var change_num_res : ChangeRoundResource
@export var round_num : int
@export_tool_button("Run")   var button_change_num : Callable = run_change_round_num
@export_tool_button("Reset") var reset_button      : Callable = reset

func _ready() -> void:
	if  change_num_res != null:
		change_num_res.set_owner_node(self, change_text)
	pass

func reset() -> void:
	if  change_num_res != null:
		change_num_res.reset()
	pass

func run_change_round_num() -> void:
	run_change_round(round_num)
	pass

func run_change_round(new_num : int) -> void:
	if  change_num_res != null:
		change_num_res.run_change_round_num(new_num)
	pass

func change_text(new_num : int) -> void:
	text = ROUND_TEXT_KEY % new_num
	pass
