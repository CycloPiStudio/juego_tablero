extends Control

var camino_index = 0

func _ready():
#	desconectar_botones_inicio()
	activar_llamadas()
	activar_botones(false)
	
	
func _button_pressed(which):
	print("Button was pressed: ", which.get_position(), which.get_index())
#	guarda la posicion a la que te mueves como partida de salida del siguiente turno
	camino_index = which.get_index()
	activar_botones(false)
	#cuando sea el final no rcp
	
	if which.get_index() == get_child_count()-1:
		
		print("AAAAAAAAAA get_child_count() ", get_child_count())
		get_parent().rpc_id(1, "juego_finalizado",ServerM.mi_jugador)
	else: 
		get_parent().rpc_id(1, "cambiar_valor_mi_dic", ServerM.mi_jugador, "posicion", which.get_position())
		print("pulso botonnnnn!!!!!")
	
func activar_llamadas():
	for b in get_children():
		b.connect("pressed", self, "_button_pressed",[b])

func activar_botones(activado, n_casillas = 0, casilla_pos = camino_index):
	if activado:
		for b in get_children():
			if b.get_index() <= casilla_pos + n_casillas and b.get_index() >= casilla_pos - n_casillas:
				b.disabled = false
			else:
				b.disabled = true
	else:
		for b in get_children():
			b.disabled = true
