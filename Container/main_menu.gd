class_name MainMenu extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.current_scene_name = get_tree().get_current_scene().name
	pass  # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_option_btn_pressed() -> void:
	var updating_window = Global.updating_window.instantiate()
	add_child(updating_window)

func _on_register_btn_pressed() -> void:
	SaveManager.load_game()
	await SaveManager.game_loaded
	get_tree().change_scene_to_file("res://Scene/LoadingScene.tscn")

func _on_login_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/LoadingScene.tscn")
