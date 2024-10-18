class_name PlayerHud extends CanvasLayer

@onready var hud: Control = $Control
@onready var money_label: Label = $Control/Layout/MoneyLabel

var hearts : Array[HeartGUI] = []

func _ready() -> void:
	_handle_scene()
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	pass

func _handle_scene():
	hud.visible = true

func update_money(_money: int, _max_money: int, _coin_effect: ItemEffectCoin) -> void:
	_max_money = Global.max_money
	_money = Global.money
	if _money < _max_money:
		money_label.text = str(_money)
	else:
		money_label.text = str(null)

func update_hp(_hp: int, _max_hp: int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)
		pass
	pass

func update_heart(_index: int, _hp: int) -> void:
	var _value : int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	pass

func update_max_hp(_max_hp: int) -> void:
	var _heart_count: int = roundi(_max_hp * 0.5)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass

func _on_pause_btn_pressed() -> void:
	if PausedMenu.is_paused != true:
		PausedMenu.show_pause_menu()
	else:
		PausedMenu.hide_pause_menu()
