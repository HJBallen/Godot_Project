extends Node2D
@onready var reproductor = preload("res://scenes/reproductor.tscn").instantiate()
@onready var seleccionPersonaje = preload("res://scenes/selectorPersonaje.tscn").instantiate()
@onready var mainMenu = get_child(0)

func _ready():
	add_child(reproductor)

func seleccionarPersonaje():
	add_child(seleccionPersonaje)
	remove_child(mainMenu)
