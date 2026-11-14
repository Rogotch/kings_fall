class_name FactoryCharacterParameters
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(character : BaseCharacter) -> CharacterParameters:
	var params : CharacterParameters = container.resolve(CharacterParameters)
	params.SetUpByData(character.data)
	character.parameters = params
	#var movement : BattleCharacterMoveService = container.resolve(BattleCharacterMoveService)
	#container.inject(movement, [character])
	return params
	pass
