extends Control
var turno = 0
var id_turno 
func _ready():
	pass # Replace with function body.
var jugadores_carga =[]
#aqui llegan las señales de los jugadores cargados

remote func juego_finalizado(gana):
	print("uuuuuuuuuuuuuuuuuuuuu FFFFFFFFFIIIIIIIIIINNNNNNNNNNNAAAAAAAAAAAALLLLLLLLLLLLLIIIIIIIIIIIIZZZZZZA")
	rpc("jugadores_fin_comunicado", gana)

remote func jugadores_cargados(id):
	
	jugadores_carga.append(id)
	ServerM.rellenar_label("jugadores cargados: " + str(id))
	if ServerM.jugadores_preparados.size() == jugadores_carga.size():
		ServerM.rellenar_label("todos listos!!!!!!")
#		manda turno y el dic jugadores
		rpc("empezar_juego", turno, ServerM.jugadores)
#		id_turno = ServerM.lista_de_peers[turno]
		
		ServerM.rellenar_label("jugadores" + str(ServerM.jugadores))
		jugadores_carga.clear()
		secuencia_de_turno()

func secuencia_de_turno():
#	numer aleatorio dado
	var numero_aleatorio = 2
	rpc_id(ServerM.jugadores["jugador" + str(turno)]["mi_id"], "activar_turno", true, numero_aleatorio)
	print("mi secuenci turno ", turno)

remote func cambiar_valor_mi_dic(jug, atri, valor):
	print("jugadores sin cambiar ", ServerM.jugadores)
	ServerM.jugadores[jug][atri] = valor
	print("cambio dic!!!!!!!")
	print("jugadores cambiados ", ServerM.jugadores)
	servidor_envia_dic_jugadores(ServerM.jugadores)

func servidor_envia_dic_jugadores(jugdic):
	rpc("jugadores_refrescan_dic", jugdic)

#var lista_sincronia = []	
remote func jugadores_sincronizados(su_id):
	
	jugadores_carga.append(su_id)
	print("lista_sincronia.size() ", jugadores_carga.size())
	print("ServerM.jugadores.size() ", ServerM.jugadores.size())
	if jugadores_carga.size() == ServerM.jugadores.size():
		jugadores_carga.clear()
		cambiar_turno()
	print("jugadores_carga.size() despues ", jugadores_carga.size())
	
#	rpc("final_turno")
func cambiar_turno():
	
	print(turno, "  TTTTTTURNOturno")
#	secuencia_de_turno()
##	var vademano = turno - (int(turno/ServerM.jugadores.size())*ServerM.jugadores.size())
##	print("vademano ", vademano)
	if turno > ServerM.jugadores.size()-1:
		turno = 0
		secuencia_de_turno()
#		print("2 turrrrnnoooooooooo!!!!!! " , turno)
		turno += 1
	else:
		secuencia_de_turno()
		turno += 1
#		print("0 y 1 turrrrnnoooooooooo!!!!!! " , turno)
		
#activa y desactiva camino
#func secuencia_de_turno():
#	for ind in ServerM.jugadores.size():
#		print("indice secuencia ", ind)
#		if turno == ServerM.jugadores["jugador" + str(ind)]["mi_turno"]:
#			rpc_id(ServerM.jugadores["jugador" + str(ind)]["mi_id"], "activar_turno", true)
#			print("sssi es mi turno ind ", ind , " si mi_turno " , ServerM.jugadores["jugador" + str(ind)]["mi_turno"])
#		else:
#			rpc_id(ServerM.jugadores["jugador" + str(ind)]["mi_id"], "activar_turno", false)
#		print("nnnno es mi turno ind ", ind,  " n mi_turno " , ServerM.jugadores["jugador" + str(ind)]["mi_turno"])
#.rpc_id(0, ServerM.miid,  "cambiar_valor_mi_dic", "posicion", which.get_position())
#	pass
