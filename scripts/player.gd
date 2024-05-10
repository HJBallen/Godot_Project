extends CharacterBody2D

signal hit
signal death
signal player_ready;
signal healed
signal new_gun
signal player_get_shield
signal shield_broken
signal regen_shield

@onready var inmune_timer = $Inmunidad
@onready var guns = []
@onready var shield_timer = $shield_timer

var DAMAGE_RATE = 1

var char_name : String
var inmune := false
var health: int
var speed : int
var gun_number :=1
var shield = false
var atk_speed :=1

func _ready():
	guns.append(get_node("Gun"))

#Funcion que se ejecuta cada frame
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

#Se encarga de hacer inmune al jugador luego de recibir un hit
func inmunidad():
	inmune = true
	inmune_timer.start()

#Controla el daño recibido
func dmg_control():
	if inmune == true:
		return null
	else:
		if shield == false:
			if  health > 0:
				health-=1
				emit_signal("hit")
			if health == 0:
				emit_signal('death')
		else:
			shield_broken.emit()
			shield_timer.start(0)
			shield = false
		inmunidad()

#Ejecuta las animacions "Idle" y "Walk"
func animar():
	if velocity != Vector2(0,0):
		$AnimatedSprite2D.play(char_name+"_walk")
	else:
		$AnimatedSprite2D.play(char_name+"_idle")

#Aumenta la velocidad de ataque de las armas del jugador
func increase_atk_speed():
	if atk_speed < 2:
		atk_speed +=atk_speed*0.1
	if atk_speed >=2:
		atk_speed = 2
	for i in guns:
			i.animation_sprite.speed_scale = atk_speed

#Aumenta el daño que inflige el jugador
func increase_damage():
	if DAMAGE_RATE<3:
		DAMAGE_RATE+=1

#Aumenta la velocidad de movimiento del jugador.
func increase_speed():
	if speed < 400:
		speed +=10
	if speed > 400:
		speed = 400
	pass

#Añade un arma al jugador. (El maximo es 4)
func add_gun():
	if gun_number<4:
		var new_gun = preload("res://scenes/gun.tscn").instantiate()
		match gun_number:
			1:
				gun_number+=1
				new_gun.global_position = Vector2(80,-14)
			2:
				gun_number+=1
				new_gun.global_position = Vector2(-18,-48)
			3:
				gun_number+=1
				new_gun.global_position = Vector2(80,-48)
		emit_signal("new_gun")
		guns.append(new_gun)
		call_deferred("add_child",new_gun)

#Añade un escudo a la vida del jugador. (Recibe un hit y se deshabilita por un tiempo)
func get_shield():
	shield = true
	player_get_shield.emit()

#Se ejecuta cuando un cuerpo colisiona con el area de daño del jugador
func _on_Player_body_entered(body):
	if body.is_in_group("mobs"):
		dmg_control()

#Se ejcuta cuando el temporizador de la inmunidad se acaba.
func _on_inmunidad_timeout():
	inmune = false

#Se ejecuta cuando el jugador colisiona con un objeto de salud. Cura al jugador
func heal(cantidad):
	if health < GLOBAL.maxHealth:
		health+= cantidad
		if health > GLOBAL.maxHealth:
			health = GLOBAL.maxHealth
		emit_signal("healed")
	else:
		pass

#Se ejcuta cuando el temporizador del escudo se acaba.
func _on_shield_timer_timeout():
	shield = true
	regen_shield.emit()
	pass # Replace with function body.
