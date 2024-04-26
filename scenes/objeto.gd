extends Area2D
signal heal
@onready var collision = $CollisionShape2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("heal")
		#queue_free()
