class_name BattleEvents
extends    RefCounted

signal battle_started
signal battle_winned
signal battle_losed
signal round_changed(number : int)
signal skill_focused(index  : int)
signal skill_toggled(index  : int, toggled_on : bool)
