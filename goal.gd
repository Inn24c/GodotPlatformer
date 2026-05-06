extends Area2D

@export var next_level: PackedScene
signal goal_in(level: PackedScene)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		goal_in.emit(next_level)
