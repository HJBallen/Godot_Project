extends Node2D


func  _ready():
	%Player.char_name = GLOBAL.character[GLOBAL.selected_char]
	match GLOBAL.character[GLOBAL.selected_char]:
		"rolo":
			%Player.health = 5
		"paisa":
			%Player.health = 3
		"costeno":
			%Player.health = 7
	%Player.emit_signal("player_ready")

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
	var new_mob = random_mob()
	%PathFollow2D.progress_ratio=randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mobs()
	pass

func _on_player_death():
	print("muelte")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
