extends CharacterBody2D

@export var movespeed: float = 300
@export var jumpforce: float = -300
@export var health: int = 3
@export var knockback_distance = 1000

signal damaged
signal healed
signal death

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var dir = Input.get_axis("move_left", "move_right")
	velocity.x = dir * movespeed

	if Input.is_action_just_pressed("jump"):
		if Input.is_action_pressed("down"):
			position.y += 2
		elif is_on_floor():
			velocity.y = jumpforce
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#if collision:
			#var col = collision.get_collider()
			#if col.is_in_group("monster"):
				#change_health(-1)
				#var knockback_dir = sign(global_position.x - col.global_position.x)
				#if knockback_dir == 0:
					#knockback_dir = -1
				#velocity.x = knockback_dir * knockback_distance

	move_and_slide()

func monster_collide(monster):
	change_health(-1)
	var knockback_dir = sign(global_position.x - monster.global_position.x)
	if knockback_dir == 0:
		knockback_dir = -1
	velocity.x = knockback_dir * knockback_distance
	move_and_slide()
	
func change_health(amount: int):
	health += amount
	if health <= 0:
		death.emit()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("fruit"):
		change_health(area.heal)
		healed.emit()

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("monster"):
		monster_collide(body)
		damaged.emit()
