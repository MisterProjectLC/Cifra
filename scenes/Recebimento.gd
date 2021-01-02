extends Control

var cifras = ["NUMEROS", "CESAR-3", "CESAR-7", "ATBASH", "REVERSO", "POLYBIUS","MORSE", "MORSE - NUMEROS"]
var alfabetos = [{'0':0, '1':1, '2':2, '3':3, '4':4, '5':5, '6':6, '7':7, '8':8, '9':9},
				{"a":0, "b":1, "c":2, "d":3, "e":4,
				"f":5, "g":6, "h":7, "i":8, "j":9,
				"k":10, "l":11, "m":12, "n":13, "o":14,
				"p":15, "q":16, "r":17, "s":18, "t":19,
				"u":20, "v":21, "w":22, "x":23, "y":24, "z":25},
				{"a":0, "b":1, "c":2, "d":3, "e":4,
				"f":5, "g":6, "h":7, "i":8, "j":9,
				"k":10, "l":11, "m":12, "n":12, "o":11,
				"p":10, "q":9, "r":8, "s":7, "t":6,
				"u":5, "v":4, "w":3, "x":2, "y":1, "z":0}]

var tipos = [0, 1, 1, 2, 1, 1, 1, 0]
var cifra_atual = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_cifra(cifra_atual)


func set_cifra(cifra):
	cifra_atual = cifra
	for i in range(4, $TabelaCifra.get_children().size()):
		if i == cifra_atual+4:
			$TabelaCifra.get_child(i).visible = true
		else:
			$TabelaCifra.get_child(i).visible = false
	$Cifra/Label.text = cifras[cifra]


func _on_LeftCifra_button_up():
	Audio.play_sound(Audio.switch)
	if cifra_atual > 0:
		set_cifra(cifra_atual-1)
	else:
		set_cifra(cifras.size()-1)


func _on_RightCifra_button_up():
	Audio.play_sound(Audio.switch)
	if cifra_atual < cifras.size()-1:
		set_cifra(cifra_atual+1)
	else:
		set_cifra(0)


func _on_LineEdit_text_changed(new_text):
	var tabela_atual = $TabelaCifra.get_child(cifra_atual+4)
	for i in range(tabela_atual.get_children().size()-1):
		tabela_atual.get_child(i).set("custom_colors/font_color", Color(0.3,0.3,0.3))
	
	if new_text.length() == 0:
		return
	
	if new_text in alfabetos[tipos[cifra_atual]]:
		var a = alfabetos[tipos[cifra_atual]][new_text]
		tabela_atual.get_child(a).set("custom_colors/font_color", Color(0,0,0))

	elif new_text.to_lower() in alfabetos[tipos[cifra_atual]]:
		var a = alfabetos[tipos[cifra_atual]][new_text.to_lower()]
		tabela_atual.get_child(a).set("custom_colors/font_color", Color(0,0,0))
