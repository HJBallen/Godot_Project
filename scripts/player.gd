extends CharacterBody2D

signal hit
signal death
signal player_ready;


var DAMAGE_RATE = 1

var char_name : String
var inmune : bool
var health
var speed = 300.

@onready var inmune_timer = $Inmunidad


func _physics_process(delta):
	
	var inicio=get_tree().get_nodes_in_group("inicio")[0].global_position
	var final=get_tree().get_nodes_in_group("final")[0].global_position
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity=direction*speed
	move_and_slide()
	limites(inicio,final)
	if direction.x>=0:
		$AnimatedSprite2D.flip_h=false
		animar()
	else:
		$AnimatedSprite2D.flip_h=true
		animar()


func inmunidad():
	inmune_timer.start()
	

func dmg_control():
	if  health > 0:
		health-=1
	elif health == 0:
		emit_signal('death')

func animar():
	if velocity != Vector2(0,0):
		$AnimatedSprite2D.play(char_name+"_walk")
	else:
		$AnimatedSprite2D.play(char_name+"_idle")



func limites(inicio,final):
	if global_position.x<inicio.x:
		global_position.x=inicio.x+5
	if global_position.x>final.x:
		global_position.x=final.x-5

	if global_position.y<inicio.y:
		global_position.y=inicio.y-5
	if global_position.y>final.y:
		global_position.y=final.y+5

func _on_Player_body_entered(body):
	if body.is_in_group("mobs"):
		emit_signal("hit")
		dmg_control()

func _on_inmunidad_timeout():
	inmune = false
