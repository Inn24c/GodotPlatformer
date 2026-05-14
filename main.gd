extends Node2D

func _ready() -> void:
	Savemanager.load_data_from_file()

func _on_new_game_pressed() -> void:
	Savemanager.reset_save_data()
	get_tree().change_scene_to_file("res://Game.tscn")
	print(Savemanager.current_level_path)

func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Game.tscn")
	print(Savemanager.current_level_path)

func _on_exit_pressed() -> void:
	get_tree().quit()
