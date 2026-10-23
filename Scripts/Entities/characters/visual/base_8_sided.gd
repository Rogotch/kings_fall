extends BaseCharacterVisual
class_name BaseEightSidedCharVis

@onready var directions_tree  : AnimationTree = $directions_tree
@onready var animation_tree   : AnimationTree = $animation_tree
@onready var main_sprite      : Sprite2D      = $main_sprite

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

@export var spritelists : Dictionary[STATE, Texture2D] 

func Idle():
	current_state = STATE.IDLE
	pass

func Attack():
	current_state = STATE.ATTACK
	pass

func Walk():
	current_state = STATE.WALK
	pass

func Run():
	current_state = STATE.RUN
	pass

func Hit():
	current_state = STATE.HIT
	pass

func Death():
	current_state = STATE.DEATH
	pass

func SetDirection(direction : Vector2):
	blend_direction = direction
	pass

func AttackHit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(global_position.direction_to(get_global_mouse_position()).normalized())
	#blend_direction = global_position.direction_to(get_global_mouse_position()).normalized()
	pass
