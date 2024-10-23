extends Sprite2D

var open_door_frame = 25
var closed_door_frame = 24
signal door_opened(door)

func _ready():
	self.frame = closed_door_frame

func _on_button_pressed():
	self.frame = open_door_frame
	door_opened.emit(self)
