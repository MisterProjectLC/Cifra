extends Node

export var nome = "Weinstein"
export var criptografia = "cesar3"
export(NodePath) var base
var messages
var turno

signal enviar_pedido

func _ready():
	turno = -1
	messages = Parser.load_file(nome)
	if get_node_or_null(base):
		get_node(base).set_personagem(self)

# override
func passar_turno():
	turno += 1
	enviar_mensagens()

func enviar_mensagens():
	pass

func enviar_pedido(texto, prioridade = 0, cripto = criptografia, titulo = nome):
	emit_signal("enviar_pedido", titulo, cripto, texto, prioridade)


# GETTER/SETTER --------------------------
func get_nome():
	return nome

func get_cripto():
	return criptografia

func set_cripto(new):
	criptografia = new

func get_local():
	return ""

func set_base(new):
	base = new

func set_turno(new):
	turno = new
