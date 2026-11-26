class_name BaseEightSidedCharVis
extends BaseCharacterVisual

@onready var directions_tree  : AnimationTree = $directions_tree
@onready var animation_tree   : AnimationTree = $animation_tree
@onready var main_sprite      : Sprite2D      = $main_sprite

var playback : AnimationNodeStateMachinePlayback:
	get:
		if animation_tree == null || animation_tree.get(&"parameters/playback") == null:
			return null
		return animation_tree.get(&"parameters/playback")

@export var blend_direction : Vector2:
	get:
		if directions_tree == null || directions_tree.get(&"parameters/blend_position") == null:
			return Vector2.ZERO
		return directions_tree.get(&"parameters/blend_position")
	set(value):
		blend_direction = value
		if directions_tree == null || directions_tree.get(&"parameters/blend_position") == null:
			return
		directions_tree.set(&"parameters/blend_position", value)

@export var spritelists : Dictionary[ANIMATION_STATE, Texture2D] 

const STATES_ANIM_NAMES : Dictionary[ANIMATION_STATE, String] = {
		ANIMATION_STATE.IDLE    : "idle",
		ANIMATION_STATE.ATTACK  : "attack",
		ANIMATION_STATE.WALK    : "walk",
		ANIMATION_STATE.RUN     : "run",
		ANIMATION_STATE.HURT    : "hit",
		ANIMATION_STATE.DEATH   : "death",
}

func get_state_by_anim_name(anim_name : String) -> ANIMATION_STATE:
	var index : int = STATES_ANIM_NAMES.values().find(anim_name)
	return STATES_ANIM_NAMES.keys()[index]
	pass

func SetState(new_state : ANIMATION_STATE) -> void:
	playback.travel(STATES_ANIM_NAMES[new_state])
	#set_spritelist(new_state)
	pass

#func set_spritelist(new_state : ANIMATION_STATE) -> void:
	#if spritelists.has(new_state):
		#main_sprite.texture = spritelists[new_state]
	#pass

func SetDirection(direction : Vector2):
	blend_direction = direction
	pass

func AttackHit():
	attack_hitted.emit()
	pass

func Died() -> void:
	z_index = -1
	pass

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	anim_finished.emit(get_state_by_anim_name(anim_name))
	pass # Replace with function body.
