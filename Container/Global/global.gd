extends Node

# Khai báo các cửa sổ và preload cảnh
@onready var updating_window = preload("res://Scene/Updating.tscn")
@onready var register_window = preload("res://Scene/RegisterWindow.tscn")

# Khai báo tên nhân vật
var character_name = ""
var current_scene_name: String = ""
var money: int = 0
var max_money: int = 9999

# Hàm để đặt tên nhân vật
func set_character_name(player_name: String) -> void:
	character_name = player_name
	print("Character name set to: " + character_name)
	
func get_character_name() -> String:
	return character_name
	
