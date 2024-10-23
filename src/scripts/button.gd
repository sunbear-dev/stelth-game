extends Sprite2D
signal button_pressed


func _on_area_2d_area_entered(area):
	button_pressed.emit()
