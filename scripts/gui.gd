extends CanvasLayer
#Variables
@onready var player = %Player
@onready var corazones = get_children()

#Reduce en 1 la vida del jugador cuando es golpeado
func _on_player_hit():
	corazones[player.health-1].get_child(0).value=0

#Instancia los corazones que seran mostrados en el stage 
func _on_player_ready():
	var new_corazon
	for i in range(player.health-1):
		new_corazon = preload("res://scenes/corazon.tscn").instantiate()
		new_corazon.global_position = corazones[i].global_position + Vector2(35,0)
		corazones.append(new_corazon)
		add_child(new_corazon)

#Regenera la vida hasta su maximo
func full_health():
	for i in corazones:
			i.get_child(0).value=1

#Controla la curacion del jugador al interactuar con un objeto curativo
func _on_player_healed():
	if player.health>=GLOBAL.maxHealth:
		full_health()
	else:
		corazones[player.health-1].get_child(0).value=1
