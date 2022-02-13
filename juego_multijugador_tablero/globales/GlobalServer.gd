extends Node

# el servidor es el jugador 0 y el cliente es el 1
var peer = NetworkedMultiplayerENet.new()
#var SERVER_PORT = 6969
var MAX_PLAYERS = 2
#var SERVER_IP = "192.168.18.32"

onready var dic_botones = {}

onready var escena_seleccionar = get_tree().get_root().get_node("Seleccionar")


func create_server(SERVER_PORT):
	
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().network_peer = peer
	print("servidor iniciado")
	
	peer.connect("peer_connected", self, "_Peer_Connected")
	peer.connect("peer_disconnected", self, "_Peer_Disconnected")
	
func create_client(SERVER_IP, SERVER_PORT):
	
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().network_peer = peer
	peer.connect("connection_failed", self, "_OnConnectionFailed")
	peer.connect("connection_succeeded", self, "_OnConnectionSucceeded")
	peer.connect("server_disconnected" , self, "_OnServerDisconnected")


func _OnConnectionFailed():
	print("Failed al servidor")
	escena_seleccionar.PrintarResult("Fallo de conecxión")
#	
func _OnConnectionSucceeded():
	print("Conectado al servidor")
	escena_seleccionar.PrintarResult("Conectado al servidor")

func _OnServerDisconnected():
	print("Servidor desconectado")
	escena_seleccionar.PrintarResult("Servidor desconectado")
	
func _Peer_Connected(player_id):
	print("User " + str(player_id) + " Connected")
	escena_seleccionar.PrintarResult("User " + str(player_id) + " Connected")
	

func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " Disconnected")
	escena_seleccionar.PrintarResult("User " + str(player_id) + " Disconnected")



#esta funcion activa ejecuta la funcion con un parametro
func Mandar_Clientes(mensaje):
	rpc("Recibir_Clientes", mensaje)
#esta funcion se ejecuta desde el servidor
remote func Recibir_Clientes(mensaje):
	escena_seleccionar.PrintarResult(mensaje)
	


	

	
	



			




