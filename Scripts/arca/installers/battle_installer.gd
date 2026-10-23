extends ArcaInstaller

const MOVE_SERVICE                 := preload("uid://dmuqidyrvwv7q")
const BATTLE_SERVICE               := preload("uid://ck1wa0af6cmcu")
const PC_INPUT_LISTENER            := preload("uid://d3tp5j8bif48f")

const CHARACTER_PREFAB             := preload("uid://c15p4go1jkf5u")
#const BATTLE_MOVE_SERVICE         := preload("uid://cs6uxoguct7df")
const TWEEN_MOVE_SERVICE           := preload("uid://8ireh7u52n2u")
const BASE_CHARACTER_CONTROLLER    := preload("uid://dwoy6jyylt0tp")
const PLAYER_CHARACTER_CONTROLLER  := preload("uid://dy3j3w1apaj2o")

const ISOMETRIC_CELL_DRAWER        := preload("uid://donhigb155mw8")
const ISOMETRIC_FIELD_DRAWER       := preload("uid://cv10vi6cx1xs")

const CHARACTERS_SPAWNER           := preload("uid://bckc2k4qgnnrm")
const VISUAL_FACTORY               := preload("uid://dco8vt4w63en6")
const BATTLE_CONTROLLERS_FACTORY   := preload("uid://yi5udytckulu")
const BATTLE_MOVEMENT_FACTORY      := preload("uid://bbrr5al44ne6p")

func install(container: ArcaContainer, ctx) -> void:
	var battle = ctx as BattleContext
	container.bind(BattleScenePathes).from_instance(battle.scene_pathes)
	container.bind(MapDisplayer).from_instance(battle.displayer)
	
	container.bind(MOVE_SERVICE).as_single()
	container.bind(BATTLE_SERVICE).as_single()
	container.bind(PC_INPUT_LISTENER).as_single()
	
	container.bind(ISOMETRIC_CELL_DRAWER).as_single(func(c: ArcaContainer): 
		var new_drawer : IsometricCellDrawer = IsometricCellDrawer.new()
		c.inject(new_drawer)
		return new_drawer)
		
	container.bind(ISOMETRIC_FIELD_DRAWER).as_single(func(c: ArcaContainer): 
		var new_drawer : IsometricFieldDrawer = IsometricFieldDrawer.new()
		c.inject(new_drawer, [battle.displayer.field_size, battle.displayer.field_start_cell])
		return new_drawer)
	
	container.bind(BASE_CHARACTER_CONTROLLER).as_transient()
	container.bind(PLAYER_CHARACTER_CONTROLLER).as_transient()
	#container.bind(BATTLE_MOVE_SERVICE).as_transient()
	container.bind(TWEEN_MOVE_SERVICE).as_transient()
	
	# Factories
	container.bind(VISUAL_FACTORY).as_single()
	container.bind(BATTLE_CONTROLLERS_FACTORY).as_single(func(c: ArcaContainer): return BATTLE_CONTROLLERS_FACTORY.new(c))
	container.bind(BATTLE_MOVEMENT_FACTORY).   as_single(func(c: ArcaContainer): return BATTLE_MOVEMENT_FACTORY.new(c))
	container.bind(BaseCharacter).as_transient(func(c : ArcaContainer):
		var character = CHARACTER_PREFAB.instantiate()
		return   character)
	container.bind(CHARACTERS_SPAWNER).as_single(func(c: ArcaContainer): return CHARACTERS_SPAWNER.new(c))
	
	container.inject(battle.displayer)
	pass
