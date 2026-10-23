class_name BattleMovementFactory
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create(character : BaseCharacter) -> BattleCharacterMoveService:
	var movement : TweenMoveService = container.resolve(TweenMoveService)
	#var movement : BattleCharacterMoveService = container.resolve(BattleCharacterMoveService)
	container.inject(movement, [character])
	return movement
	pass
