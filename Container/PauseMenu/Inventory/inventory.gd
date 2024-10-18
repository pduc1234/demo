extends CanvasLayer

signal shown
signal hidden

@onready var item_desciption: Label = $Control/Panel/ItemDesciption
@onready var audio_stream_player: AudioStreamPlayer = $Control/AudioStreamPlayer

var is_paused: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide_inv_menu()
	pass # Replace with function body.
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		if not is_paused:
			show_inv_menu()
		else:
			hide_inv_menu()
		get_viewport().set_input_as_handled()

func show_inv_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true
	shown.emit()

func hide_inv_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	hidden.emit()

func update_item_desciption(new_text : String) -> void:
	item_desciption.text = new_text

func play_audio(audio : AudioStream) -> void:
	audio_stream_player.stream = audio
	audio_stream_player.play()
