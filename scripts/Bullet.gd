extends Area2D

var travelled_distance=0
var dmg:=0

# Se ejcuta cada frame
func _physics_process(delta):
	const SPEED= 1000
	const RANGE= 1200
	var direction =Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance+= SPEED* delta
	if travelled_distance > RANGE:
		queue_free()

#Se ejecuta al colisionar con un Mob
func _on_body_entered(body):
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage(dmg)
