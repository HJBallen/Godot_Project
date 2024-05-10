extends CharacterBody2D

signal  mob_dead(mob)

@onready var animation_tree = $Sprite2D/AnimationTree
@onready var playback = $Sprite2D/AnimationTree.get("parameters/playback")
@onready var player = get_node("/root/Stage/Player")

var health := 2
var hurt : bool
var dead : bool

#Se ejecuta cada frame.
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * GLOBAL.mobs_speed
	update_animations()
	if not hurt:
		move_and_slide()

#Cambia las capas y mascaras de colision
func change_collisions():
	set_collision_layer_value(2,false)
	set_collision_mask_value(1,false)
	set_collision_mask_value(2,false)
	pass

#Spawnea un objeto de curacion de tipo Arepa
func spawn_arepa():
	var arepa = preload("res://scenes/arepa.tscn").instantiate()
	arepa.global_position = global_position
	add_sibling(arepa)
	pass

#Spawnea un objeto de curacion grande
func spawn_big_heal():
	var big_heal = preload("res://scenes/big_heal.tscn").instantiate()
	big_heal.global_position = global_position
	big_heal.get_child(0).texture = GLOBAL.big_heals[GLOBAL.selected_char]
	add_sibling(big_heal)

#Se encarga de la probabilidad de spawn de los objetos de curacion
func spawn_healing_object():
	var chance_ob1 = randi_range(1,10)
	var chance_ob2 = randi_range(1,30)
	if chance_ob2 == 1:
		spawn_big_heal()
		pass
	elif chance_ob1 == 1:
		spawn_arepa()
		pass

#Verifica el estado de las animaciones, los actualiza y transiciona de uno a otro
func update_animations():
	if velocity != Vector2.ZERO:
		animation_tree["parameters/conditions/is_walking"]=true
	if	hurt:
		animation_tree["parameters/conditions/is_hurt"] = true
	else:
		animation_tree["parameters/conditions/is_hurt"] = false
	if dead:
		animation_tree["parameters/conditions/is_dead"] = true
		change_collisions()
		playback.travel("die")

#Controla el daño recibido
func take_damage(damage):
	health -= damage
	hurt = true
	if health <= 0:
		dead = true

#Se ejecuta al finalizar una animacion
func on_animations_finished(anim_name):
	if anim_name == "hurt":
		hurt = false
	if anim_name == "die":
		change_collisions()
		spawn_healing_object()
		mob_dead.emit(self)
		queue_free()
