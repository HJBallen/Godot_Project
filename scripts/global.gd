extends Node
const uribe_dijo = [preload("res://assets/enemies/jefe/audios/jefe_quote_1.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_2.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_3.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_4.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_5.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_6.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_7.mp3"),
preload("res://assets/enemies/jefe/audios/jefe_quote_8.mp3")]

const character = ["rolo","paisa","costeno"]

const big_heals = [preload("res://assets/objects/healing/changua.png"),
preload("res://assets/objects/healing/bandeja.png"),
preload("res://assets/objects/healing/mojarra.png")]

var selected_char = 0
var maxHealth : int
var atk_speed := 1.0

var mobs_speed:= 190

