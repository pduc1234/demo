class_name Enemy
extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal enemy_damaged(hurt_box: HurtBox)
signal enemy_dead(hurt_box: HurtBox)

var player : Player
var invulnerable : bool = false
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 3

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(_take_damaged)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	move_and_slide()
	pass
	
func SetDirection(_new_direction : Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round(
		(direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()
	))
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation(state : String) -> void:
	# Cập nhật hoạt ảnh khi có hành động mới
	anim.play(AnimDirection() + "_" + state)
	pass
	
	
func AnimDirection() -> String:
	# Xác định hoạt ảnh phù hợp
	if cardinal_direction == Vector2.DOWN:
		return "front"
	elif cardinal_direction == Vector2.UP:
		return "back"
	else:
		return "side"
		
func _take_damaged(hurt_box: HurtBox) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		enemy_damaged.emit(hurt_box)
	else:
		enemy_dead.emit(hurt_box)
