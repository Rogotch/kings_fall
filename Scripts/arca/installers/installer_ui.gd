extends ArcaInstaller

const FACTORY_SKILL_UI    := preload("uid://ctbfctjwosdgk")

const SKILL_BUTTON        := preload("uid://3c8fnqg5al8n")
const SKILL_BUTTON_SCRIPT := preload("uid://b7ie5l85v1128")

func install(container: ArcaContainer, ctx) -> void:
	container.bind(FACTORY_SKILL_UI)   .as_single(func(): return FACTORY_SKILL_UI.new(container))
	container.bind(SKILL_BUTTON_SCRIPT).as_transient(func(): return SKILL_BUTTON.instantiate())
	pass
