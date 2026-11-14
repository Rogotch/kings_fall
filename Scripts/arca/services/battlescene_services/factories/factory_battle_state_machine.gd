class_name FactoryBattleTurnsSM
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(character : BaseCharacter) -> CharacterStateMachine:
	var new_state_machine : CharacterStateMachine = container.resolve(CharacterStateMachine)
	container.inject(new_state_machine, [character])
	return new_state_machine
	pass
	
