class_name State_Walk extends State

@export var SPEED : float = 100.0
@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"



func Enter() -> void:
	# Xử lý hoạt ảnh khi di chuyển
	player.UpdateAnimation("walk")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta: float) -> State:
	# Nếu đứng im sẽ chạy hoạt ảnh Idle
	if player.direction == Vector2.ZERO:
		return idle
	# Tính toán tốc độ di chuyển
	player.velocity = player.direction * SPEED
	# Phát hoạt ảnh di chuyển
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return null
	 
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	# Xử lý chuyển hoạt ảnh attack khi đang di chuyển
	if _event.is_action_pressed("attack"):
		return attack
	return null
