extends CharacterBody2D

signal hit
signal death
signal player_ready;
signal healed
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

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	velocity=direction*speed
	move_and_slide()
	#limites(inicio,final)
	if direction.x>=0:
		$AnimatedSprite2D.flip_h=false
		animar()
	else:
		$AnimatedSprite2D.flip_h=true
		animar()

func inmunidad():
	inmune = true
	inmune_timer.start()
	
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

func increase_atk_speed():
	print("atk_speed_up")
	if atk_speed < 2:
		atk_speed +=atk_speed*0.1
	if atk_speed >=2:
		atk_speed = 2
	for i in guns:
			i.animation_sprite.speed_scale = atk_speed

func increase_damage():
	print("dmg_up")
	if DAMAGE_RATE<3:
		DAMAGE_RATE+=1

func increase_speed():
	print("speed_up")
	if speed < 400:
		speed +=10
	if speed > 400:
		speed = 400
	pass

func add_gun():
	print("gun_added")
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
		guns.append(new_gun)
		call_deferred("add_child",new_gun)

func get_shield():
	print("shiel_added")
	shield = true
	player_get_shield.emit()

func _on_Player_body_entered(body):
	if body.is_in_group("mobs"):
		dmg_control()

func _on_inmunidad_timeout():
	inmune = false

func heal(cantidad):
	if health < GLOBAL.maxHealth:
		health+= cantidad
		if health > GLOBAL.maxHealth:
			health = GLOBAL.maxHealth
		emit_signal("healed")
	else:
		pass

func _on_shield_timer_timeout():
	shield = true
	regen_shield.emit()
	pass # Replace with function body.
