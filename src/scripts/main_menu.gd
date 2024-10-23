extends CanvasLayer
var scene_switcher

func _ready():
	scene_switcher = get_parent()

func _on_start_button_pressed():
	scene_switcher.load_level()

func _on_levels_button_pressed():
	scene_switcher.levels_menu()


func _on_quit_button_pressed():
	get_tree().quit()
