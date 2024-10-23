extends CanvasLayer
var scene_switcher

func _ready():
	scene_switcher = get_parent()

func _on_level_1_pressed():
	scene_switcher.set_level(1)
	scene_switcher.load_level()


func _on_level_2_pressed():
	scene_switcher.set_level(2)
	scene_switcher.load_level()

func _on_level_3_pressed():
	scene_switcher.set_level(3)
	scene_switcher.load_level()

func _on_back_pressed():
	scene_switcher.main_menu()
