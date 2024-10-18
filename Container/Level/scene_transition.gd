extends CanvasLayer

@onready var anim: AnimationPlayer = $Control/AnimationPlayer
@onready var control: Control = $Control


func _ready() -> void:
	_handle_scene()

func _handle_scene():
	var current_scene_name = get_tree().current_scene.name
	if current_scene_name == "MenuMain":
		control.visible = false
	else:
		control.visible = true
	pass

func fade_out() -> bool:
	anim.play("fade_out")
	await anim.animation_finished
	return true

func fade_in() -> bool:
	anim.play("fade_in")
	await anim.animation_finished
	return true
