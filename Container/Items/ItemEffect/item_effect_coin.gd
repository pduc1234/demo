class_name ItemEffectCoin extends ItemEffect

@export var coin_amount : int = 1
@export var audio : AudioStream

func use() -> void:
	Global.money += coin_amount
	PlayerManager.player.update_coin(coin_amount)
	Inventory.play_audio(audio)
