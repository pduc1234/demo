extends Node

const PLAYER = preload("res://Assets/Player/Player.tscn")
const INVENTORY_DATA : InventoryData = preload("res://Container/PauseMenu/Inventory/player_inventory.tres")

var player : Player
var player_spawn : bool = false


func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.5).timeout
	player_spawn = true

func add_player_instance() -> void:
	if player == null:
		player = PLAYER.instantiate()
		add_child(player)

func set_health(hp: int, max_hp: int) -> void:
	player.max_hp = max_hp
	player.hp = hp
	player.update_hp(0)

func set_player_position(_new_pos: Vector2) -> void:
	player.global_position = _new_pos

func set_as_parent(_p: Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_p: Node2D) -> void:
	_p.remove_child(player)

func set_player_money(money: int, max_money: int) -> void:
	player.money = money
	player.max_money = max_money
	player.update_coin(0)
	
