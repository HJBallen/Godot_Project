extends CharacterBody2D

@onready var player = get_node("/root/Stage/Player")
@onready var animation_tree=$Sprite2D/AnimationTree
var health=3
var hurt: bool
var dead: bool

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 160
	update_animations()
	if not hurt:
		move_and_slide()

func update_animations():
	if velocity != Vector2.ZERO:
		animation_tree["parameters/conditions/is_walking"]=true
	if hurt:
		animation_tree["parameters/conditions/is_hurt"]=true
	else:
		animation_tree["parameters/conditions/is_hurt"]=false
	if dead:
		animation_tree["parameters/conditions/is_dead"]=true
		

func take_damage():
	health -= 1
	hurt=true
	print("recibe hit")
	if health == 0:
		print("muelte")
		dead=true
		

func _on_hurt_animation_finished(anim_name):
	if anim_name=="hurt":
		hurt=false
	if anim_name=="die":
		queue_free()
		
	
