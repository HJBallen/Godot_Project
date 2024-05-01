extends TextureProgressBar

@onready var parent = get_parent()

func _ready():
	min_value = 0
	max_value = parent.shield
	value = max_value
