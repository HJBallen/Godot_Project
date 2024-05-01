extends CharacterBody2D


@onready var player = get_node("/root/Stage/Player")

var health := 3
var hurt : bool
var dead : bool

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 160
	if not hurt:
		move_and_slide()


func take_damage():
	health -= 1
	hurt = true
	if health == 0:
		dead = true

#func on_animations_finished(anim_name):
	#if anim_name == "hurt":
		#hurt = false
	#if anim_name == "die":
		#queue_free()
