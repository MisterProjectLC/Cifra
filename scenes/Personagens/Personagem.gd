extends Node

export var nome = "Weinstein"
export var criptografia = "cesar"
var turno = 0

signal enviar_pedido

var messages
func _ready():
	messages = Parser.load_file(nome) 

# override
func passar_turno(_turno):
	pass

func enviar_pedido(texto, prioridade = 0, cripto = criptografia):
	emit_signal("enviar_pedido", nome, cripto, texto, prioridade)
