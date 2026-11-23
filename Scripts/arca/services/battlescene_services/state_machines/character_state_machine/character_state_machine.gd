class_name CharacterStateMachine
extends RefCounted

signal state_changed(new_state : BaseCharacterState)

var MoveSystem          : BattleMoveSystem
var displayer           : MapDisplayer
var character_owner     : BaseCharacter
var current_state       : BaseCharacterState

static func get_inject_dependencies() -> Array:
	return [
		BattleMoveSystem,
		MapDisplayer,
		]

func inject_dependencies(
		move_system     : BattleMoveSystem,
		map_displayer   : MapDisplayer,
		characters_body : BaseCharacter,
	) -> void:
	MoveSystem          = move_system
	displayer           = map_displayer
	character_owner     = characters_body
	character_owner.controller.state_machine = self
	pass

func set_state(new_state : BaseCharacterState) -> void:
	if current_state != null:
		current_state.Exit()
	current_state = new_state
	current_state.Enter()
	state_changed.emit(current_state)
	pass

func select_cell(cell : Vector2i) -> void:
	if current_state is BaseCharacterState.Idle:
		current_state.select_cell(cell)
	pass

func Idle() -> void:
	var state : BaseCharacterState.Idle   = BaseCharacterState.Idle  .new(self, character_owner)
	set_state(state)
	pass

func Attack(skill : WarpedSkill, to_cell : Vector2i) -> void:
	var state : BaseCharacterState.Attack = BaseCharacterState.Attack.new(self, character_owner, to_cell, skill)
	set_state(state)
	pass

func Move(to_cell : Vector2i) -> void:
	var state : BaseCharacterState.Move   = BaseCharacterState.Move  .new(self, character_owner, to_cell)
	set_state(state)
	pass

func Hurt(damage : DamageContext) -> void:
	var state : BaseCharacterState.Hurt   = BaseCharacterState.Hurt  .new(self, character_owner, damage)
	set_state(state)
	pass

func Death() -> void:
	var state : BaseCharacterState.Death  = BaseCharacterState.Death .new(self, character_owner)
	set_state(state)
	pass
