@tool
class_name ChangeRoundResource
extends TweenEffect

@export var position_ratio_base      : Vector2 = Vector2.ZERO
@export var position_ratio_target    : Vector2
@export var rotation_deg_rang_target : float
@export_custom(PROPERTY_HINT_LINK, "")
var scale_base            : Vector2 = Vector2.ONE
@export_custom(PROPERTY_HINT_LINK, "")
var scale_target          : Vector2 = Vector2.ONE
@export_custom(PROPERTY_HINT_LINK, "")
var scale_change_target   : Vector2 = Vector2.ONE

@export_group("Time", "tw_time_")
@export var tw_time_position_ratio_in                 : float
@export var tw_time_scale_in                          : float
@export var tw_time_scale_change_mid_additional_delay : float
@export var tw_time_scale_change_mid                  : float
@export var tw_time_rotation_delay                    : float
@export var tw_time_rotation                          : float
@export var tw_time_change_round_num_delay            : float
@export var tw_time_position_ratio_out                : float
@export var tw_time_scale_out                         : float
@export var tw_time_before_out_delay                  : float

@export_group("Easing", "tw_ease_")
@export var tw_ease_in               : Tween.EaseType
@export var tw_ease_out              : Tween.EaseType
@export var tw_ease_scale_change_mid : Tween.EaseType
@export var tw_ease_rotation         : Tween.EaseType
#@export var tw_ease_ : Tween.EaseType

@export_group("Trans", "tw_trans_")
@export var tw_trans_in               : Tween.TransitionType
@export var tw_trans_out              : Tween.TransitionType
@export var tw_trans_scale_change_mid : Tween.TransitionType
@export var tw_trans_rotation         : Tween.TransitionType
#@export var tw_trans_ : Tween.TransitionType

func reset() -> void:
	super.reset()
	owner.offset_transform_position_ratio = Vector2.ZERO
	owner.offset_transform_scale          = scale_base
	owner.offset_transform_rotation       = 0
	pass

func run_change_round_num() -> void:
	var rotation_target : float = randf_range(-rotation_deg_rang_target, rotation_deg_rang_target)
	main_tween = owner.create_tween()
	main_tween.set_ease(tw_ease_in).set_trans(tw_trans_in)
	main_tween.set_parallel()
	main_tween.tween_property(owner, "offset_transform_position_ratio", position_ratio_target, tw_time_position_ratio_in)
	main_tween.tween_property(owner, "offset_transform_scale", scale_target, tw_time_scale_in)
	
	main_tween.tween_property(owner, "offset_transform_scale", scale_change_target, tw_time_scale_change_mid)\
			.set_delay(tw_time_scale_in + tw_time_scale_change_mid_additional_delay)\
			.from(scale_target)\
			.set_ease(tw_ease_scale_change_mid)\
			.set_trans(tw_trans_scale_change_mid)
	
	main_tween.tween_property(owner, "offset_transform_rotation", deg_to_rad(rotation_target), tw_time_rotation)\
			.set_delay(tw_time_rotation_delay)\
			.set_ease(tw_ease_rotation)\
			.set_trans(tw_trans_rotation)
	
	if outter_callable != null:
		main_tween.tween_callback(outter_callable)\
			.set_delay(tw_time_change_round_num_delay)
	main_tween.set_parallel(false)
	main_tween.tween_interval(tw_time_before_out_delay)
	main_tween.set_ease(tw_ease_out).set_trans(tw_trans_out)
	main_tween.tween_property(owner, "offset_transform_rotation", 0, 0.5)
	main_tween.parallel().tween_property(owner, "offset_transform_position_ratio", position_ratio_base, 0.5)
	main_tween.parallel().tween_property(owner, "offset_transform_scale", scale_base, 0.5)
	main_tween.play()
	pass
