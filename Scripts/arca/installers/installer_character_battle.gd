extends ArcaInstaller

# Character components
const CHARACTER_PREFAB              := preload("uid://c15p4go1jkf5u")
const CHARACTER_PARAMETERS          := preload("uid://vrlwhvgrgisa")

const TWEEN_MOVE_SERVICE            := preload("uid://8ireh7u52n2u")
const BATTLE_MOVE_SERVICE           := preload("uid://cs6uxoguct7df")

# Skills
const SKILLS_MANAGER                := preload("uid://3c7hublju527")
const SKILLS_MANAGER_CHARACTER      := preload("uid://dr81un4i6y72a")
const SKILL_STATUS                  := preload("uid://86deo768x4ww")
const SKILL_CONTEXT                 := preload("uid://c7sbqne2loa34")
const WARPED_CHARACTER_SKILL        := preload("uid://cyq4ft82kqnkf")

# Controllers
const CHARACTER_CONTROLLER_BASE     := preload("uid://dwoy6jyylt0tp")
const CHARACTER_CONTROLLER_PLAYER   := preload("uid://dy3j3w1apaj2o")

# State Machines
const STATE_MACHINE_CHARACTER       := preload("uid://t8fayspk5rf1")
const STATE_MACHINE_PLAYER          := preload("uid://bd5w7h11jnwje")

# Factories
const CHARACTERS_SPAWNER            := preload("uid://bckc2k4qgnnrm")
const FACTORY_BATTLE_CHARACTERS_SM  := preload("uid://dv6vcjdv8bdaa")
const FACTORY_BATTLE_CONTROLLERS    := preload("uid://yi5udytckulu")
const FACTORY_BATTLE_MOVEMENT       := preload("uid://bbrr5al44ne6p")
const FACTORY_CHARACTERS_PARAMETERS := preload("uid://x0r15bxhsww1")
const FACTORY_SKILLS_STATUS         := preload("uid://hbb664vlmbjs")

func install(container: ArcaContainer, ctx) -> void:
	container.bind(STATE_MACHINE_CHARACTER)      .as_transient()
	container.bind(STATE_MACHINE_PLAYER)         .as_transient()
	
	container.bind(CHARACTER_PARAMETERS)         .as_transient()
	container.bind(CHARACTER_CONTROLLER_BASE)    .as_transient()
	container.bind(CHARACTER_CONTROLLER_PLAYER)  .as_transient()
	container.bind(SKILLS_MANAGER)               .as_transient()
	container.bind(SKILLS_MANAGER_CHARACTER)     .as_transient()
	
	container.bind(SKILL_STATUS)                 .as_transient()
	container.bind(WARPED_CHARACTER_SKILL)       .as_transient()
	container.bind(SKILL_CONTEXT)                .as_transient()
	
	container.bind(BaseCharacter)                .as_transient(func():
		var character = CHARACTER_PREFAB.instantiate()
		return   character)
	
	container.bind(BATTLE_MOVE_SERVICE)          .as_transient(func():
		return TWEEN_MOVE_SERVICE.new())
	
	# Factories
	container.bind(FACTORY_SKILLS_STATUS)        .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_STATUS         .new(c))
	
	container.bind(FACTORY_CHARACTERS_PARAMETERS).as_single(func(c: ArcaContainer): return FACTORY_CHARACTERS_PARAMETERS .new(c))
	container.bind(FACTORY_BATTLE_CONTROLLERS)   .as_single(func(c: ArcaContainer): return FACTORY_BATTLE_CONTROLLERS    .new(c))
	container.bind(FACTORY_BATTLE_MOVEMENT)      .as_single(func(c: ArcaContainer): return FACTORY_BATTLE_MOVEMENT       .new(c))
	container.bind(FACTORY_BATTLE_CHARACTERS_SM) .as_single(func(c: ArcaContainer): return FACTORY_BATTLE_CHARACTERS_SM  .new(c))
	
	container.bind(        CHARACTERS_SPAWNER)   .as_single(func(c: ArcaContainer): 
		var      spawner = CHARACTERS_SPAWNER.new(c)
		c.inject(spawner)
		return   spawner)
	pass
