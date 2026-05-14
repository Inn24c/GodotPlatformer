extends Node2D

@onready var level_container = $LevelContainer
@onready var HUD = $Hud
@onready var current_level = $LevelContainer/Level
@onready var current_level_scene: PackedScene = load(Savemanager.current_level_path)

func _ready() -> void:
	load_level(current_level_scene)

func _on_level_stage_clear(level: PackedScene) -> void:
	Savemanager.current_level_path = level.resource_path
	Savemanager.save_data_to_file()
	load_level(level)
	
func _on_level_player_health_changed(health: int) -> void:
	HUD.set_HP(health)
	
func _on_level_player_death():
	load_level(current_level_scene)

func load_level(next_level: PackedScene):
	for child in level_container.get_children():
		child.queue_free()
		
	var new_level = next_level.instantiate()
	level_container.add_child(new_level)
	
	if new_level.has_signal("stage_clear"):
		new_level.stage_clear.connect(_on_level_stage_clear)
	if new_level.has_signal("player_health_changed"):
		new_level.player_health_changed.connect(_on_level_player_health_changed)
	if new_level.has_signal("player_death"):
		new_level.player_death.connect(_on_level_player_death)
	
	current_level_scene = next_level
	current_level = new_level
	
	HUD.call_deferred("set_HP", 3)
	HUD.call_deferred("set_score", 0)
