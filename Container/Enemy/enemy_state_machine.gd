class_name EnemyStateMachine
extends Node

# Khai báo State
var states : Array [EnemyState]
var prev_state : EnemyState
var current_state : EnemyState


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(current_state.Process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	ChangeState(current_state.Physics(delta))

# Khởi tạo Node Player
func Initialize(_enemy : Enemy) -> void:
	states = []
	
	for  c in get_children():
		if c is EnemyState:
			states.append(c)
			
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()
		
	if states.size() > 0:
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		


# Xử lý thay đổi hoạt ảnh
func ChangeState(new_state : EnemyState) -> void:
	if new_state == null || new_state == current_state:
		return
		
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
