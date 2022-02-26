extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _button_pressed(which):
	print("Button was pressed: ", which.get_position())

func _ready():
	for b in get_children():
		b.connect("pressed", self, "_button_pressed",[b])
