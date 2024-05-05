extends CanvasLayer

@onready var player = %Player
@onready var corazones = get_children()

var shield_heart
var is_shield_regen = false

func _process(delta):
	if is_shield_regen:
		if shield_heart.value == 100:
			is_shield_regen = false
			return null
		shield_heart.value+=1

#Se ejecuta cuando el jugadro a cargado por completo en el arborl de escenas
func _on_player_ready():
	var new_corazon
	for i in range(player.health-1):
		new_corazon = preload("res://scenes/corazon.tscn").instantiate()
		new_corazon.global_position = corazones[i].global_position + Vector2(35,0)
		corazones.append(new_corazon)
		add_child(new_corazon)

#Se ejcuta cuando un jugador recibe daño
func _on_player_hit():
	corazones[player.health].get_child(0).value=0

#Se ejcuta cuando el jugador tiene la vida maxima
func full_health():
	for i in corazones:
			i.get_child(0).value=1

#Se ejcuta cada que el jugador se cura
func _on_player_healed():
	if player.health>=GLOBAL.maxHealth:
		full_health()
	else:
		corazones[player.health-1].get_child(0).value=1

#Se ejecuta cuando el jugador obtiene el escudo
func _on_player_get_shield():
	if shield_heart == null:
		print(corazones.size())
		var new_shield_heart = preload("res://scenes/shield_bar.tscn").instantiate()
		new_shield_heart.global_position = corazones[corazones.size()-1].global_position + Vector2(35,0)
		shield_heart = new_shield_heart.get_child(0)
		shield_heart.value = 100
		add_child(new_shield_heart)
	pass # Replace with function body.

#Se ejecuta cuando el escudo del jugador rompe
func _on_player_shield_broken():
	shield_heart.value = 0
	pass # Replace with function body.

#Se ejecuta cuando el escudo pasa a regenerarse
func _on_player_regen_shield():
	is_shield_regen = true
	pass # Replace with function body.
