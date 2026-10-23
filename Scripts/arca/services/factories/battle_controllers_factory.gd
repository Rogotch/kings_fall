class_name BattleControllersFactory
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create(character : BaseCharacter, player : bool) -> BaseCharacterController:
	var controller : BaseCharacterController
	if player:
		controller = container.resolve(PlayerCharacterController)
	else:
		controller = container.resolve(BaseCharacterController)
	container.inject(controller, [character])
	return controller
	pass
