extends Node2D
#Se carga el reproductor, la seleccion de personaje y el menu
@onready var reproductor = preload("res://scenes/reproductor.tscn").instantiate()
@onready var seleccionPersonaje = preload("res://scenes/selectorPersonaje.tscn").instantiate()
@onready var mainMenu = get_child(0)

#Reproduce la musica
func _ready():
	add_child(reproductor)

#Lleva a la seleccion de personaje
func seleccionarPersonaje():
	add_child(seleccionPersonaje)
	remove_child(mainMenu)
