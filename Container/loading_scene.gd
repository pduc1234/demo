class_name LoadingScene extends Control

# Biến thanh tiến trình
@onready var progress_bar: ProgressBar = $Panel/ProgressBar
@onready var timer: Timer = $Timer

# Tốc độ tăng tiến trình
var increment_speed = 1.0

func _ready():
	progress_bar.value = 0
	progress_bar.max_value = 100  # Đảm bảo max_value được đặt bằng 100
	
# Hàm cập nhật tiến trình
func _on_timer_timeout() -> void:
	progress_bar.value += increment_speed

	if progress_bar.value < 70:
		timer.start(0.01)
	elif progress_bar.value < 80:
		timer.start(0.05)
	else:
		timer.start(0.1)

	if progress_bar.value >= 100:
		timer.stop()
		_change_scene()

# Hàm chuyển cảnh khi đạt 100%
func _change_scene():
	if Global.current_scene_name == "Tutorial":
		get_tree().change_scene_to_file("res://Scene/HomeTown.tscn")
	elif Global.current_scene_name == "MenuMain":
		get_tree().change_scene_to_file("res://Scene/Tutotial.tscn")
	else:
		get_tree().change_scene_to_file("res://Scene/MainMenu.tscn")
