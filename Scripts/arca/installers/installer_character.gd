extends ArcaInstaller

# Factories
const FACTORY_SKILLS_CONTEXT        := preload("uid://sjjbxcosx47h")
const FACTORY_SKILLS_WARPED         := preload("uid://d231oojv60465")
const FACTORY_SKILLS_MANAGERS       := preload("uid://b1wves51q0i2d")

func install(container: ArcaContainer, ctx) -> void:
	# Factories
	container.bind(FACTORY_SKILLS_CONTEXT)       .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_CONTEXT        .new(c))
	container.bind(FACTORY_SKILLS_WARPED)        .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_WARPED         .new(c))
	container.bind(FACTORY_SKILLS_MANAGERS)      .as_single(func(c: ArcaContainer): return FACTORY_SKILLS_MANAGERS       .new(c))
	pass
