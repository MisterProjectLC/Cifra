extends Control

var cifras = ["CESAR", "ATBASH", "MORSE"]
var cifra_atual = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LeftCifra_button_up():
	if cifra_atual >= 0:
		cifra_atual -= 1
	else:
		cifra_atual = cifras.size()-1
	
	$Cifra/Label.text = cifras[cifra_atual]


func _on_RightCifra_button_up():
	if cifra_atual < cifras.size()-1:
		cifra_atual += 1
	else:
		cifra_atual = 0
	
	$Cifra/Label.text = cifras[cifra_atual]
