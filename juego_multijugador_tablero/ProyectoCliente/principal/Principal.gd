extends Node

onready var menus = get_tree().get_root().get_node("Principal/Menus")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func preparar_partida():
	menus.menu_sala_visibilidad(false)
	var tablero_juego = load("res://tablero/Tablero.tscn")
	var _tablero = tablero_juego.instance()
	add_child(_tablero)
	

	
