extends CharacterBody2D

signal  mob_dead

@onready var animation_tree = $Sprite2D/AnimationTree
@onready var player = get_node("/root/Stage/Player")

var health := 4
var hurt : bool
var dead : bool

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * GLOBAL.mobs_speed
	update_animations()
	if not hurt:
		move_and_slide()

func change_collisions():
	set_collision_layer_value(2,false)
	set_collision_mask_value(1,false)
	set_collision_mask_value(2,false)
	pass

func spawn_arepa():
	var arepa = preload("res://scenes/arepa.tscn").instantiate()
	arepa.global_position = global_position
	add_sibling(arepa)
	pass

func spawn_big_heal():
	var big_heal = preload("res://scenes/big_heal.tscn").instantiate()
	big_heal.global_position = global_position
	var indice:int
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
	else:
		animation_tree["parameters/conditions/is_walking"]=false
	if	hurt:
		animation_tree["parameters/conditions/is_hurt"] = true
	else:
		animation_tree["parameters/conditions/is_hurt"] = false
	if dead:
		animation_tree["parameters/conditions/is_died"] = true
		change_collisions()
		
	else:
		animation_tree["parameters/conditions/is_died"] = false

func take_damage(damage):
	health -= damage
	hurt = true
	if health <= 0:
		dead = true

func on_animations_finished(anim_name):
	if anim_name == "hurt":
		hurt = false
	if anim_name == "die":
		spawn_healing_object()
		emit_signal('mob_dead',self)
		queue_free()
