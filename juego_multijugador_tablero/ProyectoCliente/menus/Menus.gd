extends Control

#SALA DE ESPERA
onready var Popup_sala_espera = get_node("Popup_sala")
onready var labelPlayer = preload("res://menus/utilidades_lobby/LabelPlayer.tscn")
onready var Popup_container_espera = get_node("Popup_sala/VBoxContainer")

#res://globales/Servidor.gd
func _ready():
	Popup_sala_espera.show()

	
func rellenar_y_vaciar_HBoxPlayers(ips):
	if Popup_container_espera.get_child_count() != 0:
		for n in Popup_container_espera.get_children():
			Popup_container_espera.remove_child(n)
			n.queue_free()
	for i in ips:
		var nuevo_player = labelPlayer.instance()# Create a new Sprite.
		Popup_container_espera.add_child(nuevo_player)
		nuevo_player.set_position(Popup_container_espera.get_position()) # Add it as a child of this node.
		nuevo_player.set_text(str(i))
#	print("hola")


func _on_Button_pressed():
	print("Juagdoractivado")
	ServerM.preparado()
	pass # Replace with function body.

func menu_sala_visibilidad(valor):
	if valor:
		Popup_sala_espera.show()
	else:
		Popup_sala_espera.hide()
