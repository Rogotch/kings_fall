@abstract
class_name BaseCharacterVisual
extends Node

enum STATE {IDLE, ATTACK, WALK, RUN, HIT, DEATH}

var current_state      : STATE = STATE.IDLE

@abstract func Idle()
@abstract func Attack()
@abstract func Walk()
@abstract func Run()
@abstract func Hit()
@abstract func Death()
@abstract func SetDirection(direction : Vector2)
@abstract func AttackHit()

func change_state(new_state : STATE) -> void:
	match new_state:
		STATE.IDLE:
			Idle()
		STATE.ATTACK:
			Attack()
		STATE.WALK:
			Walk()
		STATE.RUN:
			Run()
		STATE.HIT:
			Hit()
		STATE.DEATH:
			Death()
	pass
