class_name Tutorial extends Node2D

@onready var panel: Panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.set_as_parent(self)
	LevelManager.level_load_stated.connect(_free_level)
	pass # Replace with function body.


func _free_level() -> void:
	PlayerManager.unparent_player(self)
	queue_free()


func _on_tutorial_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		panel.visible = true
		$Tutorial.queue_free()
