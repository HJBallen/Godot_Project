extends Area2D
@onready var collision = $CollisionShape2D
@onready var player = get_node('/root/Stage/Player')

#Se ejecuta cuando colisiona con el jugador
func _on_body_entered(body):
	if body.is_in_group("player"):
		player.add_gun()
		queue_free()

#Se ejcuta cuando el temporizador de vida del objeto llega a 0, destruyendolo
func _on_timer_timeout():
	queue_free()
