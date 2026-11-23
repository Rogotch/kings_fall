extends ArcaInstaller

# Global services
const SERVICE_BATTLE                := preload("uid://ck1wa0af6cmcu")
const SERVICE_BATTLE_INITIATIVE     := preload("uid://bb5ndvirp27sv")
const SERVICE_MOVE                  := preload("uid://dmuqidyrvwv7q")
const ALL_CHARACTERS_CONTROLLER     := preload("uid://cjhlw8ty5mp2b")

# Input
const                INPUT_LISTENER := preload("uid://lgrvmfd3n7p8")
const             INPUT_LISTENER_PC := preload("uid://d3tp5j8bif48f")

# State Machines
const STATE_MACHINE_BATLLE_TURN     := preload("uid://c228xvjtjevc")
const STATE_MACHINE_BATTLE_INPUT    := preload("uid://uet6oj2w0ibm")
const STATE_MACHINE_BATLLE          := preload("uid://6t1om25c2bj7")

# Drawers
const DRAWER_CELLS                  := preload("uid://cnktn0e0plssk")
const DRAWER_FIELD_GRID             := preload("uid://dbpp5inmko2p8")
const DRAWER_FIELD_CELLS            := preload("uid://dhnlydoop31i4")

# Factories
const FACTORY_VISUAL                := preload("uid://dco8vt4w63en6")
const FACTORY_DRAWERS               := preload("uid://bavpfv3y5jmf6")

const BATTLE_INTERFACE              := preload("uid://cx262tev6qwf0")

func install(container: ArcaContainer, ctx) -> void:
	var battle = ctx as ContextBattle
	container.bind(BattleScenePathes)            .from_instance(battle.scene_pathes)
	container.bind(MapDisplayer)                 .from_instance(battle.displayer)
	container.bind(BattleSceneParameters)        .from_instance(battle.scene_parameters)
	
	container.bind(SERVICE_BATTLE)               .as_single()
	container.bind(SERVICE_BATTLE_INITIATIVE)    .as_single()
	container.bind(SERVICE_MOVE)                 .as_single()
	container.bind(ALL_CHARACTERS_CONTROLLER)    .as_single()
	
	container.bind(STATE_MACHINE_BATTLE_INPUT)   .as_single()
	container.bind(STATE_MACHINE_BATLLE_TURN)    .as_single()
	container.bind(STATE_MACHINE_BATLLE)         .as_single()
	
	container.bind(DRAWER_CELLS)                 .as_transient()
	container.bind(DRAWER_FIELD_GRID)            .as_transient()
	container.bind(DRAWER_FIELD_CELLS)           .as_transient()
	
	# Factories
	container.bind(FACTORY_VISUAL)               .as_single()
	container.bind(FACTORY_DRAWERS)              .as_single(func(c: ArcaContainer): return FACTORY_DRAWERS               .new(c))
	
	container.bind(INPUT_LISTENER_PC)            .as_single()
	container.bind(INPUT_LISTENER)               .as_single(func(c: ArcaContainer):
		var    listener : InputListener
		#if pc_keyboard_mouse pc_gamepad console
		listener = c.resolve(INPUT_LISTENER_PC)
		return listener)
	
	container.inject(battle.displayer)
	pass
