extends PanelContainer

onready var titulo = get_node("VBoxContainer/TituloCarta")
onready var textura = get_node("VBoxContainer/TextureRect")
onready var leyenda = get_node("VBoxContainer/PanelContainer/MarginContainer/LeyendaCarta")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in CartasDic.dic_cartas:
		print("mis cartas", i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func rellenarCarta(carta):
	var mitextura = load(CartasDic.dic_cartas[carta]["textura"])
	textura.set_texture(mitextura)
	titulo.set_text(CartasDic.dic_cartas[carta]["titulo"])
	leyenda.set_text(CartasDic.dic_cartas[carta]["leyenda"])
var num = 0
func _on_Button_pressed():
	
	if CartasDic.dic_cartas.size()-1 <= num:
		num = 0
		rellenarCarta(num)
	else:
		num+=1	
		rellenarCarta(num)
