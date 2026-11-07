class_name PlayerStateMachine
extends CharacterStateMachine

static func get_inject_dependencies() -> Array:
	return [
		BattleMoveSystem,
		MapDisplayer,
		]
	pass

func Idle() -> void:
	var state : BaseCharacterState.Idle = PlayerCharacterStates.IdleBaseSelect.new(self, character_owner, MoveSystem, displayer)
	set_state(state)
	pass
