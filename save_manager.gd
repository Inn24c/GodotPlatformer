extends Node

const SAVE_PATH = "user://savegame.json"

var current_level_path: String = ""

func save_data_to_file():
	var save_dict = {
		"level": current_level_path,
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(save_dict)
		file.store_string(json_string)
		file.close()

func load_data_from_file() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
		
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(json_string)
	if data:
		current_level_path = data.get("level", "")
		return true
		
	return false

func reset_save_data():
	current_level_path = "res://Level.tscn"
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
