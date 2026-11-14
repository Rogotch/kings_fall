class_name AllCharactersController
extends    RefCounted

signal character_died(character : BaseCharacter)

var spawner           : CharactersFactory
var battle_params     : BattleSceneParameters

var characters_all    : Array[BaseCharacter]
var characters_player : Array[BaseCharacter]
var characters_enemy  : Array[BaseCharacter]

static func get_dependencies() -> Array:
	return [
			CharactersFactory,
			BattleSceneParameters,
		]

func _init(
		characters_spawner  : CharactersFactory,
		battle_parameters   : BattleSceneParameters,
	) -> void:
	spawner       = characters_spawner
	battle_params = battle_parameters
	pass

func spawn_squads_by_params() -> void:
	spawn_squads(battle_params.squad_player, true)
	spawn_squads(battle_params.squad_enemy, false)
	pass

func spawn_squads(squad : SquadData, is_player : bool) -> void:
	for character_data in squad.squad_members:
		var spawn_position : Vector2i
		
		if is_player:
			var field_size      : Vector2i = battle_params.battle_field_parameters.field_size
			var field_direction : Vector2i = Vector2i(0, 1)
			spawn_position = (field_size * field_direction - field_direction) - character_data.start_position
		else:
			spawn_position = character_data.start_position
		
		var character : BaseCharacter = spawner.spawn(character_data, spawn_position, true)
		characters_all.append(character)
		(characters_player
		 if is_player else 
		 characters_enemy
			).append(character)
		connect_character(character)
	pass

func connect_character(character : BaseCharacter) -> void:
	pass
