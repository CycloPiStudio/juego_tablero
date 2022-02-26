extends Node
onready var menus = get_tree().get_root().get_node("Principal/Menus")
var peer = WebSocketClient.new()
var PROTO_NAME = "ludus"
#var url_host = "84.123.115.165"
var url_host = "127.0.0.1"

var jugadores_ips = []
var jugador
var jugador_preparado = false
var jugadores_preparados = []

func _ready():
	
	peer.connect_to_url("ws://" + url_host +":1404", PoolStringArray([PROTO_NAME]), true)
	get_tree().connect("connection_failed", self, "_close_network")
	get_tree().connect("connected_to_server", self, "_connected")
	get_tree().set_network_peer(peer)
	
func _close_network():
	print("connection failed")
	get_tree().set_network_peer(null)

func _connected():
	print("connection server")

#remote func rellenar_y_vaciar_lista_espera(_jugadores_ips):	
#	jugadores_ips = _jugadores_ips
#	var x = 0
#	for i in 4:
#		if jugadores_ips.size() <= x:
#			menus.cambiar_labels_players(x,"vacio")
#			x +=1
#		else:
#			menus.cambiar_labels_players(x,str(jugadores_ips[x]))
#			x +=1

func preparado():
	jugador_preparado = true 
	
	rpc_id(1,"sumar_jugador_activado",get_tree().get_network_unique_id())
	print("Activa jugador" , get_tree().get_network_unique_id())
	
remote func rellenar_y_vaciar_lista_espera(_jugadores_ips):
	menus.rellenar_y_vaciar_HBoxPlayers(_jugadores_ips)
	
