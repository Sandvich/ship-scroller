extends Label

func _on_start_button_pressed():
	get_tree().change_scene("res://scenes/combat.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
