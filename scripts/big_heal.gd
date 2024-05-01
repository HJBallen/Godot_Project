extends Area2D

#se define la señal a emitir
signal heal

@onready var collision = $CollisionShape2D
@onready var player = get_node('/root/Stage/Player')

#Si el jugador colisiona con el objeto se cura y el objeto es liberado
func _on_body_entered(body):
	if body.is_in_group("player"):
		player.heal(player.maxHealth)
		queue_free()

#Gestiona el tiempo de vida en la ejecucion del juego
#Cuando termina el tiempo el objeto es liberado
func _on_timer_timeout():
	queue_free()
