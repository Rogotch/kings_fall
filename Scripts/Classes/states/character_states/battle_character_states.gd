@abstract
class_name BaseCharacterState
extends RefCounted

var state_machine  : CharacterStateMachine
var character      : BaseCharacter
var visual         : BaseCharacterVisual          : 
	get: 
		return null if character == null else character.visual
var parameters     : CharacterParameters          : 
	get: 
		return null if character == null else character.parameters
var move_service   : BattleCharacterMoveService   : 
	get: 
		return null if character == null else character.move_service

func _init(_state_machine : CharacterStateMachine, owner_character : BaseCharacter) -> void:
	state_machine = _state_machine
	character = owner_character
	pass


func Enter()  -> void:
	visual.anim_finished.connect(anim_ended)
	pass

func Exit()   -> void:
	visual.anim_finished.disconnect(anim_ended)
	pass

func update() -> void: pass

func anim_ended(state : BaseCharacterVisual.ANIMATION_STATE) -> void:
	pass

class Idle   extends BaseCharacterState:
	func _init(_state_machine : CharacterStateMachine, owner_character : BaseCharacter) -> void:
		super._init(_state_machine, owner_character)
		pass
	
	func Enter()  -> void:
		super.Enter()
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.IDLE)
		pass
	
	func Exit()   -> void:
		super.Exit()
		pass
	
	func update() -> void:	pass
	
	pass

class Attack                 extends BaseCharacterState:
	var target : Vector2i
	var skill  : WarpedSkill
	
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter,
			new_target      : Vector2i,
			selected_skill  : WarpedSkill,
			) -> void:
		super._init(_state_machine, owner_character)
		skill  = selected_skill
		target = new_target
		pass
	
	func Enter()  -> void:
		super.Enter()
		visual.SetDirection(move_service.GetDirection(target))
		visual.SetState(skill.skill.skill_use_animation)
		#visual.SetState(BaseCharacterVisual.ANIMATION_STATE.HURT)
		visual.attack_hitted.connect(attack_hitted)
		pass
	
	func Exit()   -> void:
		super.Exit()
		visual.attack_hitted.disconnect(attack_hitted)
		pass
	
	func update() -> void:	pass
	
	func attack_hitted() -> void:
		skill.Activate(target)
		pass
	
	func anim_ended(state : BaseCharacterVisual.ANIMATION_STATE) -> void:
		state_machine.Idle()
		pass
	pass

class Move                   extends BaseCharacterState:
	var target : Vector2i
	var run_flag : bool
	
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter,
			new_target      : Vector2i,
			run             : bool = false) -> void:
		super._init(_state_machine, owner_character)
		target   = new_target
		run_flag = run
		pass
	
	func Enter()  -> void:
		super.Enter()
		visual.SetState(
			BaseCharacterVisual.ANIMATION_STATE.RUN
			if run_flag else 
			BaseCharacterVisual.ANIMATION_STATE.WALK)
		move_service.move_ended.connect(state_machine.Idle, CONNECT_ONE_SHOT)
		move_service.move_alongside_path(target, parameters.GetSpeed())
		pass
	
	func Exit()   -> void:
		super.Exit()
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
	#func Enter()  -> void:	pass
	#func Exit()   -> void:	pass
	#func update() -> void:	pass
	#pass

class Hurt    extends BaseCharacterState:
	var damage : DamageContext
	func _init(
			_state_machine  : CharacterStateMachine, 
			owner_character : BaseCharacter, 
			incoming_damage : DamageContext
		) -> void:
		super._init(_state_machine, owner_character)
		damage = incoming_damage
		pass
	
	func Enter()  -> void:
		super.Enter()
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.HURT)
		parameters.Hurt(damage)
		# TODO Добавить реакцию?
		pass
	
	func Exit()   -> void:
		super.Exit()
		pass
	
	func anim_ended(state : BaseCharacterVisual.ANIMATION_STATE) -> void:
		if parameters.IsAlive():
			state_machine.Idle()
		else:
			state_machine.Death()
		pass
	
	func update() -> void:	pass
	pass

class Death  extends BaseCharacterState:
		
	func _init(
			_state_machine  : CharacterStateMachine,
			owner_character : BaseCharacter) -> void:
		super._init(_state_machine, owner_character)
		pass
	
	func Enter()  -> void:
		super.Enter()
		move_service.Died()
		visual.SetState(BaseCharacterVisual.ANIMATION_STATE.DEATH)
		pass
	
	func Exit()   -> void :
		super.Exit()
		pass
	
	func update() -> void:	pass
	
	func anim_ended(state : BaseCharacterVisual.ANIMATION_STATE) -> void:
		visual.Died()
		pass
	pass
