extends Node2D

@export var mobs_max = 100
@export var bajas_objeto :=10

@onready var timer_mobs = $Player/Path2D/Timer


var cant_mobs :=0
var jefes_muertos := 0
var bajas_totales:=0
var racha_bajas:=0

var jefe

func  _ready():
	%Player.char_name = GLOBAL.character[GLOBAL.selected_char]
	match GLOBAL.character[GLOBAL.selected_char]:
		"rolo":
			%Player.health = 5
			%Player.speed = 300
		"paisa":
			%Player.health = 3
			%Player.speed = 350
		"costeno":
			%Player.health = 7
			%Player.speed = 250
	GLOBAL.maxHealth = %Player.health
	%Player.emit_signal("player_ready")

func _process(delta):
	if jefes_muertos == 3:
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
	

func random_mob():
	var new_zombie= preload("res://scenes/zombie.tscn").instantiate()
	var new_esqueleto= preload("res://scenes/esqueleto.tscn").instantiate()
	const Gameover=preload("res://scenes/game_over.tscn")
	var rand = randi_range(1,2)
	if	rand == 1:
		return new_esqueleto
	else:
		return new_zombie

func spawn_mobs():
	if cant_mobs < mobs_max:
		var new_mob = random_mob()
		%PathFollow2D.progress_ratio=randf()
		new_mob.global_position = %PathFollow2D.global_position
		new_mob.mob_dead.connect(_on_mob_dead)
		add_child(new_mob)
		cant_mobs +=1
	else:
		pass

func spawn_jefe():
	if jefe == null:
		var new_jefe= preload("res://scenes/jefe.tscn").instantiate()
		%PathFollow2D.progress_ratio=randf()
		new_jefe.global_position = %PathFollow2D.global_position
		jefe=new_jefe
		jefe.jefe_dead.connect(_on_jefe_dead)
		add_child(jefe)
	else:
		pass

func spawn_defensive_object(mob):
	var rng = randi_range(1,2)
	match rng:
		1:
			var shield = preload("res://scenes/shield.tscn").instantiate()
			shield.global_position = mob.global_position
			add_child(shield)
			pass
		2:
			var boots = preload("res://scenes/boots.tscn").instantiate()
			boots.global_position = mob.global_position
			add_child(boots)
			pass
	pass

func spawn_ofensive_object(mob):
	var rng = randi_range(1,3)
	match rng:
		1:
			var atk_speed = preload("res://scenes/attack_speed.tscn").instantiate()
			atk_speed.global_position = mob.global_position
			add_child(atk_speed)
			pass
		2:
			var dmg_up = preload("res://scenes/damage_up.tscn").instantiate()
			dmg_up.global_position = mob.global_position
			add_child(dmg_up)
			pass
		3:
			var add_gun = preload("res://scenes/add_gun.tscn").instantiate()
			add_gun.global_position = mob.global_position
			add_child(add_gun)
			pass
	pass

func spawn_object(mob):
	var objeto = randi_range(1,2)
	match objeto:
		1:
			spawn_defensive_object(mob)
		2:
			spawn_ofensive_object(mob)
	pass

func _on_timer_timeout():
	spawn_mobs()
	pass

func _on_player_death():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_jefe_dead():
	print("Murio uribe")
	jefes_muertos+=1
	pass

func increase_mobs_speed():
	if GLOBAL.mobs_speed < 250:
		GLOBAL.mobs_speed += 10
	elif GLOBAL.mobs_speed > 250:
		GLOBAL.mobs_speed = 250

func _on_mob_dead(mob):
	cant_mobs -=1
	bajas_totales +=1
	racha_bajas +=1
	if racha_bajas == bajas_objeto:
		increase_mobs_speed()
		racha_bajas = 0
		bajas_objeto *=2
		if mobs_max <150:
			mobs_max+=10
		else:
			mobs_max = 150
		spawn_object(mob)

func _on_spawn_jefe_timeout():
	spawn_jefe()
	pass # Replace with function body.
