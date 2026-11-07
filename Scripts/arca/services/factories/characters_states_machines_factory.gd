class_name CharactersSMF
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create(character : BaseCharacter) -> CharacterStateMachine:
	var new_state_machine : CharacterStateMachine = container.resolve(CharacterStateMachine)
	container.inject(new_state_machine, [character])
	return new_state_machine
	pass
	
func create_player_sm(character : BaseCharacter) -> PlayerStateMachine:
	var new_state_machine : PlayerStateMachine = container.resolve(PlayerStateMachine)
	container.inject(new_state_machine, [character])
	return new_state_machine
	pass
	
