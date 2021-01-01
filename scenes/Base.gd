extends Button

var nome = "Wilhelm"
var local = "Kleinburg"
var criptografia = "cesar3"

signal base_examined

func _on_Base_button_up():
	emit_signal("base_examined", nome, local, criptografia)

func get_nome():
	return nome

func get_local():
	return local

func get_criptografia():
	return criptografia

func set_criptografia(new):
	criptografia = new


func set_personagem(personagem):
	nome = personagem.get_nome()
	local = personagem.get_local()
	if local != "":
		$Label.text = nome + ", " + local
	else:
		$Label.text = nome

	criptografia = personagem.get_cripto()
