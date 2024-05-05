extends Control

signal resume
signal exit

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		resume.emit()

func _on_continue_btn_pressed():
	resume.emit()


func _on_exit_btn_pressed():
	exit.emit()
