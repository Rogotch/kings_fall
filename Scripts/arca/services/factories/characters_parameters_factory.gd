class_name CharacterParametersFactory
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create(character : BaseCharacter) -> CharacterParameters:
	var params : CharacterParameters = container.resolve(CharacterParameters)
	params.setup_by_data(character.data)
	character.parameters = params
	#var movement : BattleCharacterMoveService = container.resolve(BattleCharacterMoveService)
	#container.inject(movement, [character])
	return params
	pass
