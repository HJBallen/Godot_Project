extends Area2D
#Distancia de viaje de la bala
var travelled_distance=0

#Controla la distancia maxima de la bala y la velocidad
#La bala sale desde la posicion en donde apunta el arma
func _physics_process(delta):
	const SPEED= 1000
	const RANGE= 1200
	var direction =Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance+= SPEED* delta
	if travelled_distance > RANGE:
		queue_free()

#Controla la colision de la bala con un cuerpo o mob
func _on_body_entered(body):
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage()
