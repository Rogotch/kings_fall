extends ArcaInstaller

func install(container: ArcaContainer, ctx) -> void:
	var battle_ui : ContextBattleUI = ctx as ContextBattleUI
	
	container.bind(BattleRoundLabel).from_instance(battle_ui.round_label)
	container.inject(battle_ui.round_label)
	
	for panel in battle_ui.character_panels:
		prints(panel, panel.skills_container)
		container.inject(panel)
		container.inject(panel.skills_container)
	pass
