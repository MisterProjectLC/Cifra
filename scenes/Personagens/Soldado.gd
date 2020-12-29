extends "Personagem.gd"

export var suprimentos = 10
export var companhias = 5
export var supr_tabela = [0, 2, 3, 5]

var existente = true
var flanqueado = false
var progresso = 0
var ordem = ""

func passar_turno():
	if !existente:
		return
	.passar_turno()
	
	# Racao
	if ordem != "saquear":
		if suprimentos >= companhias:
			suprimentos -= companhias
		else:
			companhias = suprimentos
			suprimentos = 0
	
	# Combate
	if ordem == "recuar":
		progresso -= 1
	elif ordem == "atacar":
		if companhias >= 5:
			progresso += 1
		companhias -= 3
	elif ordem == "saquear":
		companhias -= 2
	else:
		companhias -= 1
	
	# Resultado
	if companhias <= 0:
		existente = false


func enviar_pedido(texto, prioridade = 0):
	if existente:
		.enviar_pedido(texto, prioridade)


func receive_suprimentos(new):
	if !flanqueado:
		suprimentos += new

func receive_companhias(new):
	if !flanqueado:
		companhias += new

# default response
func receive_message(message):
	ordem = message

func get_progresso():
	return progresso

func recolher_suprimento():
	if progresso < 0:
		return supr_tabela[0]
	else:
		return supr_tabela[progresso+1]
