extends Node2D

func random_mob():
	var new_zombie= preload("res://scenes/zombie.tscn").instantiate()
	var new_esqueleto= preload("res://scenes/esqueleto.tscn").instantiate()
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
