extends Node2D

# Không cần khai báo biến toàn cục ở đây, chỉ cần sử dụng biến cục bộ
var character_name_input: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_continue_btn_pressed() -> void:
	character_name_input = $Panel/LineEdit.text  # Lấy giá trị từ LineEdit
	Global.set_character_name(character_name_input)  # Gọi hàm từ Global để đặt tên nhân vật
	queue_free()  # Đóng cửa sổ đăng ký
