extends Node

@onready var pause_menu = $UILayer/PauseMenu

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused
	if is_paused:
		pause_menu.show()
	else:
		pause_menu.hide()

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_back_to_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_restart_pressed() -> void:
	toggle_pause()
