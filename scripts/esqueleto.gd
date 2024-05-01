extends CharacterBody2D

@onready var animation_tree = $Sprite2D/AnimationTree
@onready var playback = $Sprite2D/AnimationTree.get("parameters/playback")
@onready var player = get_node("/root/Stage/Player")

var health := 3
var hurt : bool
var dead : bool

func _physics_process(delta):
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 160
	update_animations()
	if not hurt:
		move_and_slide()

func change_collisions():
	print(collision_layer)
	collision_layer = 3
	print(collision_mask)
	collision_mask = 32
	print(collision_mask)
	pass

func spawn_arepa():
	var arepa = preload("res://scenes/arepa.tscn").instantiate()
	arepa.global_position = global_position
	add_sibling(arepa)
	pass

func spawn_big_heal():
	var big_heal = preload("res://scenes/big_heal.tscn").instantiate()
	big_heal.global_position = global_position
	big_heal.get_child(0).texture = GLOBAL.big_heals[GLOBAL.selected_char]
	add_sibling(big_heal)

func spawn_healing_object():
	var chance_ob1 = randi_range(1,10)
	var chance_ob2 = randi_range(1,30)
	if chance_ob2 == 1:
		spawn_big_heal()
		pass
	elif chance_ob1 == 1:
		spawn_arepa()
		pass

func update_animations():
	if velocity != Vector2.ZERO:
		animation_tree["parameters/conditions/is_walking"]=true
	if	hurt:
		animation_tree["parameters/conditions/is_hurt"] = true
	else:
		animation_tree["parameters/conditions/is_hurt"] = false
	if dead:
		animation_tree["parameters/conditions/is_dead"] = true
		playback.travel("die")

func take_damage():
	health -= 1
	hurt = true
	if health == 0:
		dead = true

func on_animations_finished(anim_name):
	if anim_name == "hurt":
		hurt = false
	if anim_name == "die":
		change_collisions()
		spawn_healing_object()
		queue_free()
