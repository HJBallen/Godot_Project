extends CharacterBody2D

@onready var player = get_node("/root/Stage/Player")
@onready var animation = %Esqueleto/AnimationPlayer
var health=3

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 160
	update_animations()
	move_and_slide()

func update_animations():
	if velocity == Vector2(0,0):
		pass
	else:
		animation.play("walk")

func take_damage():
	health -= 1
	print("hay daño")
	if health == 0:
		queue_free()
