extends ArcaInstaller

func install(container: ArcaContainer, ctx) -> void:
	var battle_ui : ContextBattleUI = ctx as ContextBattleUI
	
	container.bind(BattleRoundLabel).from_instance(battle_ui.round_label)
	pass
