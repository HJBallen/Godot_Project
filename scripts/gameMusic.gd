extends AudioStreamPlayer

func _ready():
	playing = true
func _process(delta):
	if get_playback_position() >= 204:
		play(26)
