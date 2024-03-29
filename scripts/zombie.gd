extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_node("/root/Stage/Player")
var health=3

func _physics_process(delta):
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 160
	update_animations()
	move_and_slide()


func update_animations():
	if velocity == Vector2(0,0):
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walk")

func take_damage():
	health -= 1
	animated_sprite.play("hurt")
	if health == 0:
		animated_sprite.play("die")
		queue_free()
