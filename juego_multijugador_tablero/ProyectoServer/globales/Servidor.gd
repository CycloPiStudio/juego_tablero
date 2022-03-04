extends Node
# conexiones
const PORT = 1404
#const PROTO_NAME = "ludus"
var peer = WebSocketServer.new()
onready var label = get_tree().get_root().get_node("Principal/RichTextLabel")

var acceso = true
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
	if acceso:
		lista_de_peers = get_tree().multiplayer.get_network_connected_peers()
		rpc("rellenar_y_vaciar_lista_espera", lista_de_peers , jugadores_preparados)
		print("Player ", id, " conectado")
		rellenar_label("Player "+ str(id) + " conectado")
	else:
		pass
func _peer_disconnected(id):
	if acceso and lista_de_peers.size() > 1:
		print("Player ", id, "desconectado")
		lista_de_peers = get_tree().multiplayer.get_network_connected_peers()
		rpc("rellenar_y_vaciar_lista_espera", lista_de_peers , jugadores_preparados)
		rellenar_label("Player "+ str(id) + " desconectado")
	else:
		pass


remote func sumar_jugador_activado(jugador_activado):
#ingrasa o elimina una id a la lista jugadores_preparados
	if jugadores_preparados.size() == 0:
		jugadores_preparados.append(jugador_activado)
		rpc("rellenar_y_vaciar_lista_espera", lista_de_peers , jugadores_preparados)
	else:
		if jugadores_preparados.find(jugador_activado) == -1:
			jugadores_preparados.append(jugador_activado)
			rpc("rellenar_y_vaciar_lista_espera", lista_de_peers , jugadores_preparados)
		else:
			jugadores_preparados.erase(jugador_activado)
			rpc("rellenar_y_vaciar_lista_espera", lista_de_peers , jugadores_preparados)
#	comprueba que la lista jugadores_preparados es igual de larga que la lista lista_de_peers
#	y lanza "preparar_jugadores"
	if jugadores_preparados.size() == lista_de_peers.size():
		acceso = false
		rellenar_label("lista de peers: " + str(lista_de_peers))
		rellenar_label("jugadores preparados: " + str(jugadores_preparados))
		rellenar_label("empezar partida")
		preparar_jugadores()
#	print("jugadores_preparados ", jugadores_preparados)

func preparar_jugadores():
	var n = 0
	rellenar_label("preparar jugadores\n")
	for i in  lista_de_peers:
		var variables_jugador_por_defecto = {"id":str(i), "combate":3, "bonus1":2, "bonus2":1}
		jugadores["jugador" + str(n)] = variables_jugador_por_defecto
		rellenar_label("jugador" + str(n) + ": "+ str(jugadores["jugador" + str(n)]))
		rpc_id(i, "establecer_jugador", n)
		n += 1
	print("jugadores ", jugadores)
	

func rellenar_label(text):
	label.add_text(str(text) + "\n")
