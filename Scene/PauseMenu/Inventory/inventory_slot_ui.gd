class_name InventorySlotUi extends Button


var slot_data : SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var nummer: Label = $Nummer


func _ready() -> void:
	texture_rect.texture = null
	nummer.text =  ""
	focus_entered.connect(item_focused)
	focus_exited.connect(item_unfocused)
	pressed.connect(item_pressed)

func set_slot_data(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	nummer.text = str(slot_data.quantity)

func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			Inventory.update_item_desciption(slot_data.item_data.description)
	pass

func item_unfocused() -> void:
	Inventory.update_item_desciption("")
	pass

func item_pressed() -> void:
	if slot_data:
		if slot_data.item_data:
			var was_used = slot_data.item_data.use()
			if was_used == false:
				return
			slot_data.quantity -= 1
			nummer.text = str(slot_data.quantity)
