extends ArcaInstaller

# Mediator
const BATTLE_EVENTS        := preload("uid://bxnbp3hrlccg8")

const DATA_BRIDGE_BATTLE   := preload("uid://ccws3owo12qh6")
#const DATA_PROVIDER   := preload("uid://qqhw6e75poru")
const RUN_CONFIGS_UI       := preload("uid://dwdx5j4e8ndp1")

func install(container: ArcaContainer, ctx) -> void:
	var run_context : ContextGameRun = ctx as ContextGameRun
	container.bind(BATTLE_EVENTS)     .as_single()
	container.bind(DATA_BRIDGE_BATTLE).as_single()
	container.bind(RUN_CONFIGS_UI)    .from_instance(run_context.run_configs.UIConfig)
	pass
