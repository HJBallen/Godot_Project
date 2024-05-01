extends Node2D

@export var mobs_max = 100

var cant_mobs :=0
var jefes_muertos := 0

var jefe

func  _ready():
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
		add_child(jefe)
		jefe.jefe_dead.connect(_on_jefe_dead)
	else:
		pass


func _on_timer_timeout():
	spawn_mobs()
	pass

func _on_player_death():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_jefe_dead():
	jefes_muertos+=1
	pass

func _on_mob_dead():
	cant_mobs -=1

func _on_spawn_jefe_timeout():
	spawn_jefe()
	pass # Replace with function body.
