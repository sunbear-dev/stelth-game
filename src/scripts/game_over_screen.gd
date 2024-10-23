extends CanvasLayer

var screen_switcher

func _ready():
	screen_switcher = get_parent()

func _on_restart_button_pressed():
	screen_switcher.load_level()


func _on_quit_button_pressed():
	screen_switcher.main_menu()
