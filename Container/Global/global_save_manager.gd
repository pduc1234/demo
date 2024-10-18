extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		money = 0,
		max_money = 9999,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = [],
}




func save_game() -> void:
	update_player_data()
	update_scene_path()
	update_item_data()
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	## Chuyển đến cảnh đã lưu
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	
	await LevelManager.level_load_stated
	
	## Đảm bảo player đã được khởi tạo
	if PlayerManager.player == null:
		PlayerManager.add_player_instance()
	
	## Đặt vị trí và trạng thái cho người chơi từ save data
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.hp, current_save.player.max_hp)
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.items)
	
	await  LevelManager.level_loaded
	
	## Phát tín hiệu cho biết game đã được load hoàn tất
	game_loaded.emit()

func update_player_data() -> void:
	var p : Player = PlayerManager.player
	current_save.player.hp = p.hp
	current_save.player.max_hp = p.max_hp
	current_save.player.money = p.money
	current_save.player.max_money = p.max_money
	#current_save.player.pos_x = p.global_position.x
	#current_save.player.pos_y = p.global_position.y
	current_save.player.pos_x = 255
	current_save.player.pos_y = 105
	
func update_scene_path() -> void:
	var p : String = "res://Scene/HomeTown.tscn"
	#for c in get_tree().root.get_children():
		#if c is Level:
			#p = c.scene_file_path
	current_save.scene_path = p

func update_item_data() -> void:
	current_save.items = PlayerManager.INVENTORY_DATA.get_save_data()
