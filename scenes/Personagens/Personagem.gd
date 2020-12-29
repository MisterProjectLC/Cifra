extends Node

export var nome = "Weinstein"
export var criptografia = "cesar"

signal enviar_pedido

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# override
func passar_turno():
	pass

func enviar_pedido(texto, prioridade = 0):
	emit_signal("enviar_pedido", nome, criptografia, texto, prioridade)
