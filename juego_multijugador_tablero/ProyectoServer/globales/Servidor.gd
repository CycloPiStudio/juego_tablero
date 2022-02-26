extends Node
# conexiones
const PORT = 1404
#const PROTO_NAME = "ludus"
var peer = WebSocketServer.new()
onready var label = get_tree().get_root().get_node("Principal/Label")

# partida
var jugadores_preparados = []

var lista_de_peers 
func _ready():
#	print(jugadores)
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("network_peer_connected", self, "_peer_connected")
	
	peer.listen(PORT, PoolStringArray(["ludus"]), true)
	get_tree().connect("server_disconnected", self, "_close_network")
	get_tree().set_network_peer(peer)

func _peer_connected(id):
	print("Player ", id, " conectado")
	lista_de_peers = get_tree().multiplayer.get_network_connected_peers()
	rpc("rellenar_y_vaciar_lista_espera", lista_de_peers)

func _peer_disconnected(id):
	print("Player ", id, "desconectado")
	lista_de_peers = get_tree().multiplayer.get_network_connected_peers()
	rpc("rellenar_y_vaciar_lista_espera", lista_de_peers)
	
remote func sumar_jugador_activado(jugador_activado):
	jugadores_preparados.append(jugador_activado)
	if jugadores_preparados.size() == lista_de_peers.size():
		print("empezar_partida")
		rpc("listos")
			

	

#var num = 0
#func establecer_jugador(id):
#	jugadores[num].append(id)
#	num += 1
#	print("jugadores: " , jugadores)
#	rpc_id(id, "establecer_jugador", num)
	
	
