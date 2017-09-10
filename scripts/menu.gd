extends Label

func _on_start_button_pressed():
	#get_tree().set_current_scene()
	print("Start button pressed!")

func _on_quit_button_pressed():
	get_tree().quit()
