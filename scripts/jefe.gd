extends CharacterBody2D

signal jefe_dead

@onready var parent = get_parent()
@onready var player = get_node("/root/Stage/Player")
@onready var animations = $Sprite2D/AnimationPlayer
@onready var health_bar = $health
@onready var shield_bar = $shield
@onready var audios = $AudioStreamPlayer
@onready var timer_escudo = $Timer_escudo

var health := 10.0
var shield := 5.0
var hurt := false
var normal:=false

func _ready():
	uribe_dijo()
	health_bar.max_value = health
	shield_bar.max_value = shield
	normal= true

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	update_animations()
	if not hurt:
		move_and_slide()

func dead():
	emit_signal("jefe_dead")
	audios.stream = GLOBAL.uribe_dijo[7]
	audios.play(0)
	visible = false
	set_collision_mask_value(1,false)
	set_collision_mask_value(2,false)
	set_collision_layer_value(2,false)

func update_animations():
	if normal:
		animations.play("normal")
	if hurt:
		animations.play("hurt")

#Actualiza la barra de escudo del jefe
func update_shield_bar():
	shield_bar.value = shield
	pass

#Selecciona aleatoriamente una frase para reproducir
func uribe_dijo():
	var quote = randi_range(1,7)
	audios.stream = GLOBAL.uribe_dijo[quote-1]
	audios.play(0)
	pass

#Actualiza la barra de vida del jugador
func update_health_bar():
	health_bar.value = health
	pass

func take_damage(damage):
	if shield > 0:
		shield -= damage
		update_shield_bar()
	else:
		health -= damage
		if health <= 0:
			dead()
		update_health_bar()
	timer_escudo.start(0)
	hurt = true
	normal = false

func _on_animation_finished(anim_name):
	match anim_name:
		"hurt":
			hurt=false
			normal=true
	pass # Replace with function body.

#Audio que se reproduce al morir el jefe
func _on_audio_finished():
	if audios.stream == GLOBAL.uribe_dijo[7]:
		queue_free()

#Regenera el escudo del jefe pasado un tiempo
func _on_timer_escudo_timeout():
	shield=5
	update_shield_bar()
	pass # Replace with function body.
