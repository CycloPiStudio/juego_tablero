extends Node

onready var menus = get_tree().get_root().get_node("Principal/Menus")

# Called when the node enters the scene tree for the first time.
func _ready():
	 # Replace with function body.
#	OS.window_fullscreen = true
	OS.set_keep_screen_on(true)
	print(OS.get_name())
#	OS.show_virtual_keyboard("player",  true)
	pass

func preparar_partida():
	menus.menu_sala_visibilidad(false)
	var tablero_juego = load("res://tablero/Tablero.tscn")
	var _tablero = tablero_juego.instance()
	add_child(_tablero)
	menus.Popup_container_controles(true)

	
