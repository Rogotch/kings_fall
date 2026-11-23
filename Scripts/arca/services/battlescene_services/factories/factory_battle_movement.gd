class_name FactoryBattleMovement
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func Create(character : BaseCharacter) -> BattleCharacterMoveService:
	var movement : BattleCharacterMoveService = container.resolve(BattleCharacterMoveService)
	#var movement : BattleCharacterMoveService = container.resolve(BattleCharacterMoveService)
	container.inject(movement, [character])
	return movement
	pass
