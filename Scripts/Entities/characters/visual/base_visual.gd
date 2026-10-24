@abstract
class_name BaseCharacterVisual
extends Node

enum ANIMATION_STATE {IDLE, ATTACK, WALK, RUN, HURT, DEATH}

var current_state : ANIMATION_STATE = ANIMATION_STATE.IDLE

@abstract func SetState(new_state : ANIMATION_STATE) -> void
@abstract func SetDirection(direction : Vector2) -> void
@abstract func AttackHit()
