class_name BattleControllersFactory
extends RefCounted

var container   : ArcaContainer

func _init(arca_container: ArcaContainer) -> void:
	container = arca_container
	pass

func create(character : BaseCharacter, player : bool) -> BaseCharacterController:
	var controller : BaseCharacterController
	
	#var listener   : InputListener = container.resolve(InputListener)
	
	#if player:
		#controller = container.resolve(PlayerCharacterController)
	#else:
		#controller = container.resolve(BaseCharacterController)
	controller = container.resolve(BaseCharacterController)
	controller.is_player = player
	container.inject(controller, [character])
	return controller
	pass
