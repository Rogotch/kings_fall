class_name CharactersFactory
extends RefCounted

var container   : ArcaContainer
var parent_node : Node2D

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	parent_node = (container.resolve(BattleScenePathes) as BattleScenePathes).characters_node
	pass

func spawn(data : CharacterData, map_position : Vector2i, player : bool) -> BaseCharacter:
	var character : BaseCharacter = container.resolve(BaseCharacter)
	container.inject(character, [player])
	character.data = data
	parent_node.add_child(character)
	character.configure_character(map_position)
	return character
	pass
