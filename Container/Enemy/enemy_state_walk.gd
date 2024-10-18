class_name EnemyStateWalk
extends EnemyState


@export var anim_name : String = "walk"
@export var walk_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.8
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : EnemyState

var _timer : float = 0.0
var _direction :Vector2

func init() -> void:
	pass

func Enter() -> void:
	_timer = randf_range(state_cycles_min, state_cycles_max) * state_animation_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * walk_speed
	enemy.SetDirection(_direction)
	enemy.UpdateAnimation(anim_name)
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	 
func Physics(_delta: float) -> EnemyState:
	return null
	
