extends Control


func _ready():
#	desconectar_botones_inicio()
	activar_botones()
	activar_llamadas()
	
func _button_pressed(which):
	print("Button was pressed: ", which.get_position(), which.get_index())

func activar_llamadas():
	for b in get_children():
		b.connect("pressed", self, "_button_pressed",[b])

func activar_botones(casilla_pos = 0 , n_casillas = 0):
	for b in get_children():
		if b.get_index() <= casilla_pos + n_casillas and b.get_index() >= casilla_pos - n_casillas:
			b.disabled = false
		else:
			b.disabled = true
