extends Area2D
@onready var collision = $CollisionShape2D
@onready var player = get_node('/root/Stage/Player')

func _on_body_entered(body):
	if body.is_in_group("player"):
		player.increase_damage()
		queue_free()


func _on_timer_timeout():
	queue_free()
