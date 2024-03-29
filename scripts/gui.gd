extends CanvasLayer

@onready var player = %Player
@onready var corazones = get_children()

func _ready():
	var new_corazon
	for i in range(player.health-1):
		new_corazon = preload("res://scenes/corazon.tscn").instantiate()
		new_corazon.global_position = corazones[i].global_position + Vector2(35,0)
		corazones.append(new_corazon)
		add_child(new_corazon)



func _on_player_hit():
	print('hubo hit')
	corazones[player.health-1].get_child(0).value=0
