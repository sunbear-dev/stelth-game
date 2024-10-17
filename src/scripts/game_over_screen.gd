extends CanvasLayer


func _on_restart_button_pressed():
	get_parent().retry()


func _on_quit_button_pressed():
	get_tree().quit()
