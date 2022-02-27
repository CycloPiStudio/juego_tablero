extends Node
# conexiones
const PORT = 1404
#const PROTO_NAME = "ludus"
var peer = WebSocketServer.new()
onready var label = get_tree().get_root().get_node("Principal/Label")

# partida
var jugadores_preparados = []
var jugadores = {}
var lista_de_peers 
func _ready():
#	print(jugadores)
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("network_peer_connected", self, "_peer_connected")
	
	peer.listen(PORT, PoolStringArray(["bre"]), true)
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
#		rechaza nuevas conecxiones
#		peer.set_refuse_new_network_connections(true)
		preparar_jugadores()
		
		
func preparar_jugadores():
	var n = 0
	for i in  lista_de_peers:
		jugadores["jugador"+str(n)] = str(i)
		n += 1
		rpc_id(i, "establecer_jugador", n)
	print("jugadores ", jugadores)
	print("jugadores[jugador0]", jugadores["jugador0"])
	
