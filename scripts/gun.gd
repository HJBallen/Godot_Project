extends Area2D

#se carga el sprite del arma y el sonido
@onready var animation_sprite = get_node("WeaponShaft/Pistol")
@onready var audio = $AudioStreamPlayer

#Reproduce la animacion de disparo 
#Apunta el arma hacia los enemigos que entren en la zona de colision
func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		animation_sprite.play("shoot")
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		if cos(rotation) > 0:
			animation_sprite.flip_v = false
		else:
			animation_sprite.flip_v = true

#controla la accion de disparar del arma
func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	audio.play(0)
	%ShootingPoint.add_child(new_bullet)

#Genera un loop de disparo
func _on_pistol_animation_looped():
	shoot()
