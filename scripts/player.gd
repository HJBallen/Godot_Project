extends CharacterBody2D

const SPEED = 300.0


func _physics_process(delta):

	var inicio=get_tree().get_nodes_in_group("inicio")[0].global_position
	var final=get_tree().get_nodes_in_group("final")[0].global_position
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity=direction*SPEED
	move_and_slide()
	limites(inicio,final)
	if direction.x>0:
		$AnimatedSprite2D.flip_h=false
		animar()
	else:
		$AnimatedSprite2D.flip_h=true
		animar()
		
		
	
func animar():
	if velocity.length()>0.0:
		$AnimatedSprite2D.play("caminar")
	else:
		$AnimatedSprite2D.play("parado")

func limites(inicio,final):
	if global_position.x<inicio.x:
		global_position.x=inicio.x+5
	if global_position.x>final.x:
		global_position.x=final.x-5

	if global_position.y<inicio.y:
		global_position.y=inicio.y-5
	if global_position.y>final.y:
		global_position.y=final.y+5
	

