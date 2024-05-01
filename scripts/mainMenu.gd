extends CanvasLayer

func _on_button_start_pressed():
	get_parent().seleccionarPersonaje()
	queue_free()


func _on_button_exit_pressed():
	get_tree().quit()
