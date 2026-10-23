class_name VisualFactory
extends RefCounted

func load_visual_node(character : BaseCharacter) -> BaseCharacterVisual:
	var visual = (load(character.data.character_visual) as PackedScene).instantiate()
	character.visual_point.add_child(visual)
	character.visual = visual
	return visual
	pass
