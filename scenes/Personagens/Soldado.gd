extends "Personagem.gd"

export var _suprimentos = 10
export var _companhias = 5
export var _supr_tabela = [0, 2, 3, 5]

export var local = "Endesberg"
var _existente = true
var _flanqueado = false
var _progresso = 0
var _ordem = ""

func passar_turno(turno):
	if !_existente:
		return false
	
	# Tomar Ações ---
	tomar_acoes(turno)
	
	# Rodar turno básico ---
	# Racao
	if _ordem != "Saquear":
		if _suprimentos >= _companhias:
			_suprimentos -= _companhias
		else:
			_companhias = _suprimentos
			_suprimentos = 0
	
	# Combate
	if _ordem == "Recuar":
		_progresso -= 1
	elif _ordem == "Atacar":
		if _companhias >= 5:
			_progresso += 1
		_companhias -= 3
	elif _ordem == "Saquear":
		_companhias -= 2
	else:
		_companhias -= 1
	
	# Resultado
	if _companhias <= 0:
		_existente = false
		return false
	
	# Enviar Mensagens ---
	enviar_mensagens(turno)
	
	# Reset ---
	_ordem = ""
	return true


func tomar_acoes(_turno):
	pass


func enviar_pedido(texto, prioridade = 0, cifra = criptografia, titulo = nome + ", " + local):
	if _existente:
		.enviar_pedido(texto, prioridade, cifra, titulo)


func receive_suprimentos(new):
	if !_flanqueado or new < 0:
		_suprimentos += new

func receive_companhias(new):
	if !_flanqueado or new < 0:
		_companhias += new

# default response
func receive_message(message):
	_ordem = message

# GETTERS -----------------------------------------
func get_local():
	return local

func get_progresso():
	return _progresso

func get_ordem():
	return _ordem

func recolher_suprimento():
	if _progresso < 0:
		return _supr_tabela[0]
	else:
		return _supr_tabela[_progresso+1]
