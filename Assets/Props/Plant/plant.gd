class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(OnDamaged)
	
func OnDamaged(hurt_box: HurtBox) -> void:
	TakeDamage(hurt_box.damage)  # Lấy damage từ đối tượng HurtBox và truyền vào TakeDamage

func TakeDamage(_damage: int) -> void:
	queue_free()
	pass
