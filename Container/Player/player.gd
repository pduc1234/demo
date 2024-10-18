class_name Player
extends CharacterBody2D

# Khai báo biến
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var invulnerable : bool = false
var max_hp : int = 6
var money = 0
var max_money : int = 9999
var coin_effect = ItemEffectCoin.new()

@export var hp : int = 6
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox


signal DirectionChaged(new_direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

func _ready() -> void:
	PlayerManager.player = self
	# Truyền Player sang các tệp con của State Machine
	state_machine.Initialize(self)
	hit_box.Damaged.connect(_take_damage)
	update_hp(99)
	pass

func _process(_delta):
	# Xử lý hướng di chuyển
	#direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	pass

func _physics_process(_delta):
	move_and_slide()  # Di chuyển nhân vật

func SetDirection() -> bool:
	# Kiểm tra hướng hiện tại
	if direction == Vector2.ZERO:
		return false
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[direction_id]
		
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	DirectionChaged.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else  1
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

func _take_damage(hurt_box: HurtBox) -> void:
	if invulnerable == true:
		return
	update_hp(-hurt_box.damage)
	if hp > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		update_hp(99)
	pass

func update_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHub.update_hp(hp, max_hp)
	pass

func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invulnerable = false
	hit_box.monitoring = true
	pass

func update_coin(delta: int) -> void:
	money = clampi(money + delta, 0, max_money)
	PlayerHub.update_money(money, max_money, coin_effect)
	pass
