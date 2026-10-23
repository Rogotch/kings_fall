extends Node2D

@export var battle_context: BattleContext 
@export var test_character : CharacterData
var spawner : CharactersFactory

func _ready() -> void:
	spawner = battle_context.container.resolve(CharactersFactory)
	spawner.spawn(test_character, Vector2i(1, 2), false)
	var character : BaseCharacter = spawner.spawn(test_character, Vector2i(2, 2), true)
	#await get_tree().create_timer(2).timeout
	#character.move_service.move_to_cell(Vector2i(2, 3))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
