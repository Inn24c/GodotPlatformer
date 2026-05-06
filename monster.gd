extends CharacterBody2D

@export var speed: int = 100
var target = null

func _physics_process(delta: float) -> void:
	if not target:
		return

	var dir = sign(target.global_position.x - global_position.x)
	velocity.x = dir * speed
	if dir != 0:
		$AnimatedSprite2D.flip_h = dir < 0

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	target = null
