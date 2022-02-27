extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var escena_jugador = preload("res://jugadores/Jugador.tscn")
onready var camino_juego = get_node("Camino")
# Called when the node enters the scene tree for the first time.
func _ready():
	meter_jugadores() # Replace with function body.

func meter_jugadores():
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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#rojo e11717
#verde 4ce820
#amarllo e8ef0e
#azul 1d30cc
#rosa e915e6
#naranja e8a413
#blanco ffffff
