extends Control

#SALA DE ESPERA
onready var Popup_sala_espera = get_node("Popup_sala")
onready var Popup_container_controles = get_node("Popup_controles")
onready var Popup_cartas = get_node("Popup_cartas")
onready var labelPlayer = preload("res://menus/utilidades_lobby/LabelPlayer.tscn")
#onready var labelPlayer = preload("res://menus/utilidades_lobby/LineEditPlayer.tscn")
onready var boton = get_node("Popup_sala/Button")
onready var Popup_container_espera = get_node("Popup_sala/VBoxContainer")

#res://globales/Servidor.gd
func _ready():
	Popup_sala_espera.show()
	boton.disabled = true

# consulta la lista jugadores_ips y la lista de jugadores preparados
# para mostrarlos en pantalla 	
func rellenar_y_vaciar_HBoxPlayers(ids, jugpre):
#	comprueba si esta lleno y vacia el "Popup_sala/VBoxContainer"
	if Popup_container_espera.get_child_count() != 0:
		for n in Popup_container_espera.get_children():
			Popup_container_espera.remove_child(n)
			n.queue_free()
#	llena el "Popup_sala/VBoxContainer" con labes "res://menus/utilidades_lobby/LabelPlayer.tscn"
	for i in ids:
		var nuevo_player = labelPlayer.instance()
		Popup_container_espera.add_child(nuevo_player)
		nuevo_player.set_position(Popup_container_espera.get_position()) # Add it as a child of this node.
#		comprueba que la id "i" de ids esta en la lista de preparados y lo muestra 
		if jugpre.has(i):
			 nuevo_player.set_text(str(i) + " preparado")
		else:
			nuevo_player.set_text(str(i) + " espera")
#	print("hola")
func boton_desactivado(val):
	boton.disabled = val

func _on_Button_pressed():
	print("Juagdor activado")
	ServerM.preparado()
	pass # Replace with function body.

func menu_sala_visibilidad(valor):
	if valor:
		Popup_sala_espera.show()
	else:
		Popup_sala_espera.hide()

func Popup_container_controles(valor):
	if valor:
		Popup_container_controles.show()
	else:
		Popup_container_controles.hide()


func _on_Button_cartas_pressed():
	if Popup_cartas.hide():
		Popup_cartas.show()
	else:
		Popup_cartas.hide()
