extends CharacterBody2D

#Señales
signal hit
signal death
signal player_ready;
signal healed

#Variables
var DAMAGE_RATE = 1
var char_name : String
var inmune : bool
var health: int
var speed = 300.

@onready var inmune_timer = $Inmunidad

#Controla el movimiento segun la tecla presionada
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity=direction*speed
	move_and_slide()
	if direction.x>=0:
		$AnimatedSprite2D.flip_h=false
		animar()
	else:
		$AnimatedSprite2D.flip_h=true
		animar()

func inmunidad():
	inmune_timer.start()

#Controla el daño al recibir un hit por parte de los mobs 
func dmg_control():
	if  health > 0:
		health-=1
	if health == 0:
		emit_signal('death')

#Ejecuta las animaciones de caminar o estar quieto/idle
func animar():
	if velocity != Vector2(0,0):
		$AnimatedSprite2D.play(char_name+"_walk")
	else:
		$AnimatedSprite2D.play(char_name+"_idle")

#Si colisiona con un mob, emite una señal de golpe para gestionar el daño
func _on_Player_body_entered(body):
	if body.is_in_group("mobs"):
		emit_signal("hit")
		dmg_control()

func _on_inmunidad_timeout():
	inmune = false

#Controla la curacion al colisionar con un objeto 
func heal(cantidad):
	if health < GLOBAL.maxHealth:
		health+= cantidad
		if health > GLOBAL.maxHealth:
			health = GLOBAL.maxHealth
		emit_signal("healed")
	else:
		pass
	
	
