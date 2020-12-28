extends Button

var nome = "Wilhelm, Kleinburg"
var criptografia = "cesar"
var texto = "Estou em perigo no momento. Preciso de 200 tropas."

signal pedido_acessado

func setup(nome_, cripto, texto_):
	self.nome = nome_
	$Label.text = nome_
	self.criptografia = cripto
	self.texto = texto_

func get_nome():
	return nome

func get_cripto():
	return criptografia

func get_texto():
	return texto


func _on_Pedido_button_up():
	emit_signal("pedido_acessado", criptografia, texto)
