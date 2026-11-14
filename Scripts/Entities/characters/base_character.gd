extends CharacterBody2D
class_name BaseCharacter

@onready
var collision     : CollisionShape2D   = $collision
@onready
var visual_point  : Node2D             = $visual_point

var factory_visual : FactoryVisual

var data           : CharacterData
var controller     : BaseCharacterController
var move_service   : BattleCharacterMoveService
var visual         : BaseCharacterVisual
var parameters     : CharacterParameters
var skills_manager : SkillsManager

static func get_inject_dependencies() -> Array:
	return [
		FactoryBattleMovement,
		FactoryVisual,
		FactoryBattleControllers,
		FactoryCharacterParameters,
		FactorySkillsManagers,
		]
	pass

func inject_dependencies(
		factory_movement        : FactoryBattleMovement, 
		factory_new_visual      : FactoryVisual, 
		factory_controllers     : FactoryBattleControllers,
		factory_params          : FactoryCharacterParameters,
		factory_skills_managers : FactorySkillsManagers,
		player                  : bool
		) -> void:
	factory_visual = factory_new_visual
	factory_movement       .Create(self)
	factory_controllers    .Create(self, player)
	factory_params         .Create(self)
	factory_skills_managers.Create(self)
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
	factory_visual.load_visual_node(self)
	controller.state_machine.Idle()
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
