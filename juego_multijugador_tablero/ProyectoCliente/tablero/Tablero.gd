extends Control

var turno 
var jugadores
onready var escena_jugador = preload("res://jugadores/Jugador.tscn")
onready var camino_juego = get_node("Camino")
onready var mosca = get_node("CanvasLayerHub/SpriteMosca")
# Called when the node enters the scene tree for the first time.

func _ready():
	cargar_juego() # Replace with function body.
remote func jugadores_fin_comunicado(ganado):
	print("FFFFFFFFIIIIIIIIIINNNNNNNNNNNNNNNNNN CCCCOOO", ganado)

func cargar_juego():
	var salida = camino_juego.get_child(0).get_position()
	var colores = ["1d30cc", "e11717", "4ce820", "e8ef0e", "e915e6", "e8a413", "ffffff"]
	var num = 0
	for i in ServerM.jugadores_ips:
		
		var nuevo_jugador = escena_jugador.instance()# Create a new Sprite.
		add_child(nuevo_jugador)
		nuevo_jugador.set_name("jugador" + str(num))
		nuevo_jugador.get_child(0).modulate = Color("#" + colores[num])
	
		nuevo_jugador.set_position(salida + Vector2(num*80 , 0 )) # Add it as a child of this node.
		if i == ServerM.miid:
			mosca.modulate = Color("#" + colores[num])
		num +=1

	rpc_id(1, "jugadores_cargados", ServerM.miid)


remote func empezar_juego(_turno, _jugadores):
	print("start!!!!" , _turno, _jugadores)
	turno = _turno
	jugadores = _jugadores
#	ciclo_turno(_turno, _jugadores)
	sincronizar_jugadores(jugadores)


	



remote func activar_turno(act, num_ale):
	camino_juego.activar_botones(act, 6)
	print("activar_botones ", act)

remote func jugadores_refrescan_dic(jugdic):
	jugadores = jugdic
	sincronizar_jugadores(jugadores)


func sincronizar_jugadores(jug):
	for n in jug.size():
#		print("jug indice ",n)
		get_node("jugador" + str(n)).set_position(jug["jugador" + str(n)]["posicion"])
#		print("jugador posicion", jug["jugador" + str(n)]["posicion"])
	rpc_id(1, "jugadores_sincronizados", ServerM.miid)
		
#func jugador_acabar_turno():
#	rpc_id(1, "server_recive_final_turno")
	
#rojo e11717
#verde 4ce820
#amarllo e8ef0e
#azul 1d30cc
#rosa e915e6
#naranja e8a413
#blanco ffffff
