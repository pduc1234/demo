class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"

func Enter() -> void:
	# Gọi hoạt ảnh Idle 
	player.UpdateAnimation("idle")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta: float) -> State:
	# Xử lý chuyển hoạt ảnh khi di chuyển
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	 
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	# Xử lý hoạt ảnh khi tấn công
	if _event.is_action_pressed("attack"):
		return attack
	return null
