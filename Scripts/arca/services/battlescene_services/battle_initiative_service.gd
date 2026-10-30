class_name InitiativeService
extends    RefCounted

var characters_array   : Array[BaseCharacter]
var round_initiative   : Array[BaseCharacter]
var current_initiative_num : int = 0


func base_set_up_charactrers(all_characters : Array[BaseCharacter]) -> void:
	characters_array = all_characters
	pass

func append_character(character : BaseCharacter) -> void:
	characters_array.append(character)
	pass

func calculate_initiative_by_arr(characters : Array[BaseCharacter]) -> Array[BaseCharacter]:
	var sort_array = characters
	sort_array.sort_custom(func(character_1 : BaseCharacter,         character_2 : BaseCharacter):
								return character_1.parameters.initiative > character_2.parameters.initiative )
	return sort_array
	pass

func update_initiative() -> void:
	round_initiative = calculate_initiative_by_arr(characters_array)
	pass
