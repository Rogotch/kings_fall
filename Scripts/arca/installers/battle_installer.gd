extends ArcaInstaller

# Global services
const                BATTLE_SERVICE := preload("uid://ck1wa0af6cmcu")
const     BATTLE_INITIATIVE_SERVICE := preload("uid://bb5ndvirp27sv")
const                  MOVE_SERVICE := preload("uid://dmuqidyrvwv7q")

# Input
const                INPUT_LISTENER := preload("uid://lgrvmfd3n7p8")
const             PC_INPUT_LISTENER := preload("uid://d3tp5j8bif48f")

# Character components
const CHARACTER_PREFAB              := preload("uid://c15p4go1jkf5u")
const CHARACTER_PARAMETERS          := preload("uid://vrlwhvgrgisa")
const TWEEN_MOVE_SERVICE            := preload("uid://8ireh7u52n2u")
#const BATTLE_MOVE_SERVICE          := preload("uid://cs6uxoguct7df")

# Controllers
const     BASE_CHARACTER_CONTROLLER := preload("uid://dwoy6jyylt0tp")
const   PLAYER_CHARACTER_CONTROLLER := preload("uid://dy3j3w1apaj2o")
const     ALL_CHARACTERS_CONTROLLER := preload("uid://cjhlw8ty5mp2b")

# State Machines
const STATE_MACHINE_CHARACTER       := preload("uid://t8fayspk5rf1")
const STATE_MACHINE_PLAYER          := preload("uid://bd5w7h11jnwje")
const STATE_MACHINE_BATLLE_TURN     := preload("uid://c228xvjtjevc")
const STATE_MACHINE_BATTLE_INPUT    := preload("uid://uet6oj2w0ibm")
const STATE_MACHINE_BATLLE          := preload("uid://6t1om25c2bj7")

# Drawers
const                  CELLS_DRAWER := preload("uid://cnktn0e0plssk")
const             FIELD_GRID_DRAWER := preload("uid://dbpp5inmko2p8")
const            FIELD_CELLS_DRAWER := preload("uid://dhnlydoop31i4")

# Factories
const CHARACTERS_SPAWNER            := preload("uid://bckc2k4qgnnrm")
#const  BATTLE_STATE_MACHINE_FACTORY := preload("uid://dmrjyiexoe8y")
const  BATTLE_CHARACTERS_SM_FACTORY := preload("uid://dv6vcjdv8bdaa")
const                VISUAL_FACTORY := preload("uid://dco8vt4w63en6")
const    BATTLE_CONTROLLERS_FACTORY := preload("uid://yi5udytckulu")
const       BATTLE_MOVEMENT_FACTORY := preload("uid://bbrr5al44ne6p")
const CHARACTERS_PARAMETERS_FACTORY := preload("uid://x0r15bxhsww1")
const               DRAWERS_FACTORY := preload("uid://bavpfv3y5jmf6")

const BATTLE_INTERFACE              := preload("uid://cx262tev6qwf0")


func install(container: ArcaContainer, ctx) -> void:
	var battle = ctx as BattleContext
	container.bind(BattleScenePathes)            .from_instance(battle.scene_pathes)
	container.bind(MapDisplayer)                 .from_instance(battle.displayer)
	container.bind(BattleSceneParameters)        .from_instance(battle.scene_parameters)
	
	container.bind(MOVE_SERVICE)                 .as_single()
	container.bind(BATTLE_SERVICE)               .as_single()
	container.bind(BATTLE_INITIATIVE_SERVICE)    .as_single()
	container.bind(ALL_CHARACTERS_CONTROLLER)    .as_single()
	
	container.bind(PC_INPUT_LISTENER)            .as_single()
	
	container.bind(STATE_MACHINE_BATTLE_INPUT)   .as_single()
	container.bind(STATE_MACHINE_BATLLE_TURN)    .as_single()
	container.bind(STATE_MACHINE_BATLLE)         .as_single()
	
	container.bind(CELLS_DRAWER)                 .as_transient()
	container.bind(FIELD_GRID_DRAWER)            .as_transient()
	container.bind(FIELD_CELLS_DRAWER)           .as_transient()
	
	container.bind(STATE_MACHINE_CHARACTER)      .as_transient()
	container.bind(STATE_MACHINE_PLAYER)         .as_transient()
	
	container.bind(CHARACTER_PARAMETERS)         .as_transient()
	container.bind(BASE_CHARACTER_CONTROLLER)    .as_transient()
	container.bind(PLAYER_CHARACTER_CONTROLLER)  .as_transient()
	container.bind(TWEEN_MOVE_SERVICE)           .as_transient()
	#container.bind(BATTLE_MOVE_SERVICE).as_transient()
	
	container.bind(BaseCharacter)                .as_transient(func(c : ArcaContainer):
		var character = CHARACTER_PREFAB.instantiate()
		return   character)
	
	# Factories
	container.bind(VISUAL_FACTORY)               .as_single()
	container.bind(CHARACTERS_PARAMETERS_FACTORY).as_single(func(c: ArcaContainer): return CHARACTERS_PARAMETERS_FACTORY .new(c))
	container.bind(BATTLE_CONTROLLERS_FACTORY)   .as_single(func(c: ArcaContainer): return BATTLE_CONTROLLERS_FACTORY    .new(c))
	container.bind(BATTLE_MOVEMENT_FACTORY)      .as_single(func(c: ArcaContainer): return BATTLE_MOVEMENT_FACTORY       .new(c))
	container.bind(BATTLE_CHARACTERS_SM_FACTORY) .as_single(func(c: ArcaContainer): return BATTLE_CHARACTERS_SM_FACTORY  .new(c))
	#container.bind(BATTLE_STATE_MACHINE_FACTORY) .as_single(func(c: ArcaContainer): return BATTLE_STATE_MACHINE_FACTORY  .new(c))
	container.bind(DRAWERS_FACTORY)              .as_single(func(c: ArcaContainer): return DRAWERS_FACTORY               .new(c))
	
	container.bind(INPUT_LISTENER)               .as_single(func(c: ArcaContainer):
		var    listener : InputListener
		#if pc_keyboard_mouse pc_gamepad console
		listener = c.resolve(PC_INPUT_LISTENER)
		return listener)
	
	container.bind(        CHARACTERS_SPAWNER)   .as_single(func(c: ArcaContainer): 
		var      spawner = CHARACTERS_SPAWNER.new(c)
		c.inject(spawner)
		return   spawner)
		#var new_factory : DrawersFactory = DrawersFactory.new(c)
		#c.inject(new_factory)
		#return new_factory)
	
	container.inject(battle.displayer)
	pass
