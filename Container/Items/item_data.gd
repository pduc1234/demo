class_name IteamData extends Resource

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D

@export_category("Item Use Effect")
@export var effects : Array[ItemEffect]

func use() -> bool:
	if effects.size() == 0:
		return false
	
	for e in effects:
		if e:
			e.use()
	return true
