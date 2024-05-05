extends Control

signal resume
signal exit

func _on_continue_btn_pressed():
	print("resumir")
	resume.emit()


func _on_exit_btn_pressed():
	print("salir")
	exit.emit()
