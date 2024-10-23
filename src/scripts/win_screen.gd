extends CanvasLayer
var scene_switcher

func _ready():
	scene_switcher = get_parent()

func _on_button_pressed():
	scene_switcher.load_level()


func _on_quit_button_pressed():
	scene_switcher.main_menu()
