extends RefCounted
class_name CharacterStateMachine

var character_owner : BaseCharacter
var current_state : BaseCharacterState

func set_state(new_state : BaseCharacterState) -> void:
	if current_state != null:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	pass

func Idle() -> void:
	var state : BaseCharacterState.Idle = BaseCharacterState.Idle.new(character_owner)
	set_state(state)
	pass

func Attack(to_cell : Vector2i) -> void:
	var state : BaseCharacterState.Attack = BaseCharacterState.Attack.new(character_owner, to_cell)
	set_state(state)
	pass

func Move(to_cell : Vector2i) -> void:
	var state : BaseCharacterState.Move = BaseCharacterState.Move.new(character_owner, to_cell)
	set_state(state)
	pass

func Hit(value : int) -> void:
	var state : BaseCharacterState.Hurt = BaseCharacterState.Hurt.new(character_owner, value)
	set_state(state)
	pass

func Death() -> void:
	var state : BaseCharacterState.Death = BaseCharacterState.Death.new(character_owner)
	set_state(state)
	pass
