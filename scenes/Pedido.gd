extends Button

var nome = "Wilhelm, Kleinburg"
var criptografia = "cesar"
var texto = "Estou em perigo no momento. Preciso de 200 tropas."
var prioridade = 0

signal pedido_acessado

func setup(nome_, cripto, texto_, prioridade_):
	self.nome = nome_
	$Label.text = nome_
	self.criptografia = cripto
	self.texto = texto_
	self.prioridade = prioridade_

func get_nome():
	return nome

func get_cripto():
	return criptografia

func get_texto():
	return texto

func get_prioridade():
	return prioridade

func _on_Pedido_button_up():
	emit_signal("pedido_acessado", criptografia, texto)
