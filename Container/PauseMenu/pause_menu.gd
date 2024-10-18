extends CanvasLayer

@onready var save_btn: Button = $VBoxContainer/SaveBtn
@onready var load_btn: Button = $VBoxContainer/LoadBtn
@onready var quit_btn: Button = $VBoxContainer/QuitBtn


var is_paused: bool = false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide_pause_menu()
	pass # Replace with function body.
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if not is_paused:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	save_btn.grab_focus()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false

func _on_save_btn_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()

func _on_load_btn_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await  LevelManager.level_load_stated
	hide_pause_menu()


func _on_quit_btn_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	get_tree().quit()
