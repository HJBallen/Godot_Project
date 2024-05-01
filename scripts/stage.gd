extends Node2D

func  _ready():
	#Selecciona el personaje y asigna una cantidad de vida segun el personaje
	%Player.char_name = GLOBAL.character[GLOBAL.selected_char]
	match GLOBAL.character[GLOBAL.selected_char]:
		"rolo":
			%Player.health = 5
		"paisa":
			%Player.health = 3
		"costeno":
			%Player.health = 7
	GLOBAL.maxHealth = %Player.health
	%Player.emit_signal("player_ready")

#Realiza el spawn de mobs con un probabilidad del 50% de ser esqueleto o zombie
func random_mob():
	var new_zombie= preload("res://scenes/zombie.tscn").instantiate()
	var new_esqueleto= preload("res://scenes/esqueleto.tscn").instantiate()
	const Gameover=preload("res://scenes/game_over.tscn")
	var rand = randi_range(1,2)
	if	rand == 1:
		return new_esqueleto
	else:
		return new_zombie

#Instancia un mob random
func spawn_mobs():
	var new_mob = random_mob()
	%PathFollow2D.progress_ratio=randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

#Tiempo entre spawn de mobs 
func _on_timer_timeout():
	spawn_mobs()
	pass

#Al morir el jugador cambia la escena a game over
func _on_player_death():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
