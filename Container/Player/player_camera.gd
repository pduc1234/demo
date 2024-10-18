class_name PlayerCamera extends Camera2D

@onready var player: Player = $".."

var zoom_speed : float = 100.0
var zoom_margin : float = 0.3
var zoom_min : float = 2.3
var zoom_max : float = 5.0
var zoom_pos : Vector2 = Vector2()
var zoom_factor : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundsChaged.connect(UpdateLimits)
	UpdateLimits(LevelManager.current_tilemap_bounds)
	
	zoom = Vector2(2, 2)
	if player:  # Thay đổi thành đường dẫn đúng đến người chơi
		zoom_pos = player.position
	pass # Replace with function body.

func _process(delta: float) -> void:
	zoom.x = lerp(zoom.x, zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom_factor, zoom_speed * delta)
	
	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)
	if player:  # Thay đổi thành đường dẫn đúng đến người chơi
		zoom_pos = player.position
	# Zoom in
	if Input.is_action_pressed("zoom_in"):
		zoom_factor = clamp(zoom_factor + 0.01, zoom_min, zoom_max)  # Giảm zoom_factor để zoom in
		zoom_pos = player.position

	# Zoom out
	if Input.is_action_pressed("zoom_out"):
		zoom_factor = clamp(zoom_factor - 0.01, zoom_min, zoom_max)  # Tăng zoom_factor để zoom out
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_factor = clamp(zoom_factor + 0.1, zoom_min, zoom_max)  # Giảm zoom_factor để zoom in
			zoom_pos = get_global_mouse_position()  # Lưu vị trí chuột
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_factor = clamp(zoom_factor - 0.1, zoom_min, zoom_max)  # Tăng zoom_factor để zoom out

# Cập nhật giới hạn cho Camera
func UpdateLimits(bounds: Array[Vector2]) -> void:
	if bounds == []:
		return
	limit_left = int (bounds[0].x)
	limit_top = int (bounds[0].y)
	limit_right = int (bounds[1].x)
	limit_bottom = int (bounds[1].y)
	pass
