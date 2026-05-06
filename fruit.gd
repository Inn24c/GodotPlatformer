extends Area2D

@export var heal = 1

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		#body.health += heal
		get_tree().call_deferred("queue_free")
