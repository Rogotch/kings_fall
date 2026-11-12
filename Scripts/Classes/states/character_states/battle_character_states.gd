@abstract
class_name BaseCharacterState
extends RefCounted

var state_machine  : CharacterStateMachine
var character      : BaseCharacter
var visual         : BaseCharacterVisual   : 
	get: 
		return null if character == null else character.visual
var parameters     : CharacterParameters   : 
	get: 
		return null if character == null else character.parameters

func _init(_state_machine : CharacterStateMachine, owner_character : BaseCharacter) -> void:
	state_machine = _state_machine
	character = owner_character
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void: pass



class Idle   extends BaseCharacterState:
	func _init(_state_machine : CharacterStateMachine, owner_character : BaseCharacter) -> void:
		super._init(_state_machine, owner_character)
		pass
	
	func enter()  -> void:
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.IDLE)
		pass
	
	func exit()   -> void:
		pass
	
	func update() -> void:	pass
	
	pass

class Attack                 extends BaseCharacterState:
	var target : Vector2i
	
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter,
			new_target      : Vector2i) -> void:
		super._init(_state_machine, owner_character)
		target = new_target
		pass
	
	func enter()  -> void:
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.ATTACK)
		state_machine.Idle()
		pass
	
	func exit()   -> void:	pass
	
	func update() -> void:	pass
	pass

class Move                   extends BaseCharacterState:
	var target : Vector2i
	var run_flag : bool
	var move_service     : BattleCharacterMoveService   : 
		get: 
			return null if character == null else character.controller.move_service
	
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter,
			new_target      : Vector2i,
			run             : bool = false) -> void:
		super._init(_state_machine, owner_character)
		target   = new_target
		run_flag = run
		pass
	
	func enter()  -> void:
		visual.SetState(
			BaseCharacterVisual.ANIMATION_STATE.RUN
			if run_flag else 
			BaseCharacterVisual.ANIMATION_STATE.WALK)
		move_service.move_ended.connect(state_machine.Idle, CONNECT_ONE_SHOT)
		move_service.move_alongside_path(target, parameters.get_speed())
		pass
	
	func exit()   -> void:
		if  move_service.move_ended.is_connected(state_machine.Idle):
			move_service.move_ended.disconnect(  state_machine.Idle)
		pass
	
	func update() -> void:	pass
	pass

#class Run    extends BaseState:
	#func get_state_enum() -> STATE:
		#return STATE.RUN
		#pass
	#func _init(owner_character : BaseCharacter) -> void:
		#super._init(owner_character)
		#pass
	#func enter()  -> void:	pass
	#func exit()   -> void:	pass
	#func update() -> void:	pass
	#pass

class Hurt    extends BaseCharacterState:
	
	func _init(
			_state_machine  : CharacterStateMachine, 
			owner_character : BaseCharacter, 
			damage          : int) -> void:
		super._init(_state_machine, owner_character)
		pass
	
	func enter()  -> void:
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.HURT)
		pass
	
	func exit()   -> void:	pass
	
	func update() -> void:	pass
	pass

class Death  extends BaseCharacterState:
		
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter) -> void:
		super._init(_state_machine, owner_character)
		pass
	
	func enter()  -> void:
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.DEATH)
		pass
	
	func exit()   -> void:	pass
	
	func update() -> void:	pass
	pass
