extends CanvasLayer
const character = ["rolo","paisa","costeno"]
const char_descriptions = ["Simple.\nEstandar.", "Esperazan de vida corta. \nEstilo de vida frenetico.", "Viven mucho. \nSe mueven poco."]
var select_index = 0

func _ready():
	update_sprite(select_index)
	update_description(select_index)
	update_name(select_index)

func update_sprite(index):
		$AnimatedSprite2D.play(character[index])

func update_description(index):
	$description.text = char_descriptions[index]

func update_name(index):
	$char_name.text = character[index].to_upper()

func _on_button_left_pressed():
	if	select_index <= 0:
		select_index = 2
	else:
		select_index-=1

	update_name(select_index)
	update_sprite(select_index)
	update_description(select_index)


func _on_button_right_pressed():
	if	select_index >=2:
		select_index = 0
	else:
		select_index+=1
	update_name(select_index)
	update_sprite(select_index)
	update_description(select_index)


func _on_button_ok_pressed():
	get_tree().change_scene_to_file("res://scenes/stage.tscn")
	GLOBAL.selected_char = select_index
