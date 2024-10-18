class_name State_Attack extends State


# Khai báo biến
var attacking : bool = false
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@export var attack_sound : AudioStream
@onready var anim : AnimationPlayer = $"../../AnimationPlayer"
@onready var audio : AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var idle : State = $"../Idle"
@onready var walk : State = $"../Walk"
@onready var hurt_box : HurtBox = %AttackHurtBox


func Enter() -> void:
	# Xử lý hoạt ảnh, animation
	player.UpdateAnimation("attack")
	anim.animation_finished.connect(EndAttack)
	# Xử lý âm thanh khi tấn công, sword sound
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	
	attacking = true
	
	hurt_box.monitoring = true
	pass
	
func Exit() -> void:
	# Xử lý hoạt ảnh khi exit state
	anim.animation_finished.disconnect(EndAttack)
	attacking = false
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = false
	pass
	
func Process(_delta: float) -> State:
	# Dừng khi tấn công
	player.velocity -= player.velocity * decelerate_speed * _delta
	# Tiếp tục hành động khác sau khi tấn công
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	 
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null

# Func xử lý kết thúc tấn công
func EndAttack(_newAnimName : String) -> void:
	attacking = false
