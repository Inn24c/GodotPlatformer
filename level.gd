extends Node2D

signal stage_clear(next_level: PackedScene)

@onready var player = $Player
@onready var goal = $Goal

signal player_health_changed(amount: int)
signal player_death

func _ready() -> void:
	if player:
		player.damaged.connect(_on_player_damaged)
		player.death.connect(_on_player_death)
		player.healed.connect(_on_player_healed)
	if goal:
		goal.goal_in.connect(_on_goal_goal_in)

func _on_player_damaged() -> void:
	player_health_changed.emit(player.health)

func _on_player_death() -> void:
	player_death.emit()

func _on_player_healed() -> void:
	player_health_changed.emit(player.health)

func _on_goal_goal_in(level: PackedScene) -> void:
	stage_clear.emit(level)
