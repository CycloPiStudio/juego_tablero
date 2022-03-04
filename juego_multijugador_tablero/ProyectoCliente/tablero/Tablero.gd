extends Control

var turno

onready var escena_jugador = preload("res://jugadores/Jugador.tscn")
onready var camino_juego = get_node("Camino")
# Called when the node enters the scene tree for the first time.

func _ready():
	cargar_juego() # Replace with function body.

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
		num +=1
		
#	rpc_id(1,"jugadores_cargados", ServerM.miid)
	rpc_id(1, "jugadores_cargados", ServerM.miid)
#	ServerM.menus
#	Popup_container_controles
#todos los clientes  se printan
#remotesync func todos_cargados(text):
#	print("todos_cargados", text)
	
remote func empezar_juego(_turno):
	print("start!!!!" , _turno)
	turno = _turno
#rojo e11717
#verde 4ce820
#amarllo e8ef0e
#azul 1d30cc
#rosa e915e6
#naranja e8a413
#blanco ffffff
