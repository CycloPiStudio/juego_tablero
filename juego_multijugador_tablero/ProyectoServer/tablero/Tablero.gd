extends Control
var turno = 0

func _ready():
	pass # Replace with function body.
var jugadores_carga =[]
#aqui llegan las señales de los jugadores cargados
remote func jugadores_cargados(id):
	
	jugadores_carga.append(id)
	ServerM.rellenar_label("jugadores cargados: " + str(id))
	if ServerM.jugadores_preparados.size() == jugadores_carga.size():
		ServerM.rellenar_label("todos listos!!!!!!")
		rpc("empezar_juego", turno)
#var jugadores_carga =[]
#remotesync func todos_cargados(text):
#	jugadores_carga.append(text)
#	ServerM.rellenar_label("printarse todos " + str(text))
#	if ServerM.jugadores_preparados.size() == jugadores_carga.size():
#		ServerM.rellenar_label("todos listos!!!!!!")
		
