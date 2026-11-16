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
const SKILLS_MANAGER                := preload("uid://3c7hublju527")

# Skills
const SKILL_STATUS                  := preload("uid://86deo768x4ww")
const SKILL_CONTEXT                 := preload("uid://c7sbqne2loa34")
const WARPED_CHARACTER_SKILL        := preload("uid://cyq4ft82kqnkf")

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
const FACTORY_BATTLE_CHARACTERS_SM  := preload("uid://dv6vcjdv8bdaa")
const FACTORY_VISUAL                := preload("uid://dco8vt4w63en6")
const FACTORY_BATTLE_CONTROLLERS    := preload("uid://yi5udytckulu")
const FACTORY_BATTLE_MOVEMENT       := preload("uid://bbrr5al44ne6p")
const FACTORY_CHARACTERS_PARAMETERS := preload("uid://x0r15bxhsww1")
const FACTORY_DRAWERS               := preload("uid://bavpfv3y5jmf6")
const FACTORY_SKILLS_CONTEXT        := preload("uid://sjjbxcosx47h")
const FACTORY_SKILLS_STATUS         := preload("uid://hbb664vlmbjs")
const FACTORY_WARPED_SKILLS         := preload("uid://d231oojv60465")
const FACTORY_SKILLS_MANAGERS       := preload("uid://b1wves51q0i2d")

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
	container.bind(SKILLS_MANAGER)               .as_transient()
	
	container.bind(SKILL_STATUS)                 .as_transient()
	container.bind(WARPED_CHARACTER_SKILL)       .as_transient()
	container.bind(SKILL_CONTEXT)                .as_transient()
	#container.bind(BATTLE_MOVE_SERVICE).as_transient()
	
	
	#container.bind(BaseCharacter)                .as_transient(func(c : ArcaContainer):
	container.bind(BaseCharacter)                .as_transient(func():
		var character = CHARACTER_PREFAB.instantiate()
		return   character)
	
	# Factories
	container.bind(FACTORY_VISUAL)               .as_single()
	container.bind(FACTORY_SKILLS_CONTEXT)       .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_CONTEXT        .new(c))
	container.bind(FACTORY_SKILLS_STATUS)        .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_STATUS         .new(c))
	container.bind(FACTORY_WARPED_SKILLS)        .as_single(func(c: ArcaContainer): return FACTORY_WARPED_SKILLS         .new(c))
	container.bind(FACTORY_SKILLS_MANAGERS)      .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_MANAGERS       .new(c))
	
	container.bind(FACTORY_CHARACTERS_PARAMETERS).as_single(func(c: ArcaContainer): return FACTORY_CHARACTERS_PARAMETERS .new(c))
	container.bind(FACTORY_BATTLE_CONTROLLERS)   .as_single(func(c: ArcaContainer): return FACTORY_BATTLE_CONTROLLERS    .new(c))
	container.bind(FACTORY_BATTLE_MOVEMENT)      .as_single(func(c: ArcaContainer): return FACTORY_BATTLE_MOVEMENT       .new(c))
	container.bind(FACTORY_BATTLE_CHARACTERS_SM) .as_single(func(c: ArcaContainer): return FACTORY_BATTLE_CHARACTERS_SM  .new(c))
	container.bind(FACTORY_DRAWERS)              .as_single(func(c: ArcaContainer): return FACTORY_DRAWERS               .new(c))
	
	container.bind(PC_INPUT_LISTENER)            .as_single()
	container.bind(INPUT_LISTENER)               .as_single(func(c: ArcaContainer):
		var    listener : InputListener
		#if pc_keyboard_mouse pc_gamepad console
		listener = c.resolve(PC_INPUT_LISTENER)
		return listener)
	
	container.bind(        CHARACTERS_SPAWNER)   .as_single(func(c: ArcaContainer): 
		var      spawner = CHARACTERS_SPAWNER.new(c)
		c.inject(spawner)
		return   spawner)
		#var new_factory : FactoryDrawers = FactoryDrawers.new(c)
		#c.inject(new_factory)
		#return new_factory)
	
	container.inject(battle.displayer)
	pass
