class_name CharactersFactory
extends RefCounted

var container   : ArcaContainer
var parent_node : Node2D

static func get_inject_dependencies() -> Array:
	return [
		BattleScenePathes,
	]
	pass

func inject_dependencies(pathes : BattleScenePathes) -> void:
	parent_node = pathes.characters_node
	pass

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func spawn(data : CharacterData, map_position : Vector2i, player : bool) -> BaseCharacter:
	var character : BaseCharacter = container.resolve(BaseCharacter)
	character.data = data
	container.inject(character, [player])
	parent_node.add_child(character)
	character.configure_character(map_position)
	return character
	pass
