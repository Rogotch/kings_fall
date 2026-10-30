@abstract
class_name BattleState
extends RefCounted

func enter() -> void:
	pass

func exit() -> void:
	pass

# TODO Start Battle
class StartBattle   extends BattleState:
	pass

# TODO Battle
class Battle        extends BattleState:
	pass

# TODO Victory
class Victory       extends BattleState:
	pass

# TODO Lose
class Lose          extends BattleState:
	pass
