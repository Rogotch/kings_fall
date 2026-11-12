class_name InitiativeService
extends    RefCounted

var characters_array       : Array[BaseCharacter]
var round_initiative       : Array[BaseCharacter]
var current_num_initiative : int = 0
var current_num_round      : int = 0

func HasLefRoundCharacters() -> bool:
	return current_num_initiative < round_initiative.size()
	pass

func NewRound() -> void:
	current_num_round += 1
	current_num_initiative = 0
	pass

func NextCharacter() -> BaseCharacter:
	var character : BaseCharacter = round_initiative[current_num_initiative]
	current_num_initiative += 1
	return character
	pass

func BaseSetUpCharactrers(all_characters : Array[BaseCharacter]) -> void:
	characters_array = all_characters
	pass

func AppendCharacter(character : BaseCharacter) -> void:
	characters_array.append(character)
	pass

func UpdateInitiative() -> void:
	round_initiative = calculate_initiative_by_arr(characters_array)
	pass

func calculate_initiative_by_arr(characters : Array[BaseCharacter]) -> Array[BaseCharacter]:
	var sort_array = characters
	sort_array.sort_custom(func(character_1 : BaseCharacter,         character_2 : BaseCharacter):
						return (character_1.parameters.initiative >  character_2.parameters.initiative # Ходит раньшле тот, у кого инициатива выше
							|| (character_1.parameters.initiative == character_2.parameters.initiative # При равной инициативе предпочтение отдаётся игроку
							&&  character_1.controller.is_player)))
	return sort_array
	pass
