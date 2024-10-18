class_name EnemyStateDead
extends EnemyState


@export var anim_name : String = "dead"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0


@export_category("AI")

var _direction : Vector2
var _damaged_positon : Vector2

func init() -> void:
	enemy.enemy_dead.connect(_on_enemy_dead)
	pass

func Enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damaged_positon)
	enemy.SetDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.UpdateAnimation(anim_name)
	enemy.anim.animation_finished.connect(_on_animation_finished)
	pass
	
func Exit() -> void:
	
	pass
	
func Process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	 
func Physics(_delta: float) -> EnemyState:
	return null
	
func _on_enemy_dead(hurt_box: HurtBox) -> void:
	_damaged_positon = hurt_box.global_position
	state_machine.ChangeState(self)

func _on_animation_finished(_a: String) -> void:
	enemy.queue_free()
