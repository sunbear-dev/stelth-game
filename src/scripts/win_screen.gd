extends CanvasLayer


func _on_button_pressed():
	get_parent().next_level()


func _on_quit_button_pressed():
	get_parent().main_menu()
