extends CharacterBody2D
class_name BaseCharacter

@onready var collision    : CollisionShape2D   = $collision
@onready var visual_point : Node2D             = $visual_point

var data                : CharacterData
var controller          : BaseCharacterController
var move_service        : BattleCharacterMoveService
var visual              : BaseCharacterVisual
var visual_factory      : VisualFactory

static func get_inject_dependencies() -> Array:
	return [BattleMovementFactory, VisualFactory, BattleControllersFactory]
	pass

func inject_dependencies(
		movement_factory    : BattleMovementFactory, 
		new_visual_factory  : VisualFactory, 
		controllers_factory : BattleControllersFactory,
		player              : bool
		) -> void:
	visual_factory = new_visual_factory
	movement_factory.create(self)
	controllers_factory.create(self, player)
	pass

#static func get_dependencies() -> Array:
	#return [BattleMoveSystem]
#func _init(move_service: BattleMoveSystem) -> void:
	#MoveSystem = move_service
	#pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func configure_character(on_position : Vector2i) -> void:
	move_service.place_on_position(on_position)
	visual_factory.load_visual_node(self)
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
