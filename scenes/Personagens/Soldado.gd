extends "Personagem.gd"

export var _suprimentos = 10
export var _companhias = 5
var _recem = 0
export var _supr_tabela = [0, 2, 3, 5]

export var local = "Endesberg"
var _existente = true
var _flanqueado = false
var _progresso = 0
var _ordem = ""
var _message_received = ""

func passar_turno():
	if !_existente:
		return false
	
	# Manutencao ----------
	turno += 1
	_message_received = ""
	
	# Tomar Ações ---
	tomar_acoes()
	
	# Rodar turno básico ---
	# Racao
	if _ordem != "Saquear":
		if _suprimentos >= _companhias:
			_suprimentos -= _companhias
		else:
			_companhias = _suprimentos
			_suprimentos = 0
	
	_companhias += _recem
	_recem = 0
	
	# Combate
	if _ordem == "Recuar":
		_progresso -= 1
	elif _ordem == "Atacar":
		_progresso += 1
		_companhias -= 3
	elif _ordem == "Saquear":
		_companhias -= 2
	else:
		_companhias -= 1
	
	# Resultado
	if _companhias <= 0:
		fim()
		return false
	
	# Enviar Mensagens ---
	enviar_mensagens()
	
	# Reset ---
	_ordem = ""
	return true


func tomar_acoes():
	pass


func enviar_pedido(texto, prioridade = 0, cifra = criptografia, titulo = nome + ", " + local):
	if _existente:
		.enviar_pedido(texto, prioridade, cifra, titulo)


func receive_suprimentos(new):
	if !_flanqueado or new < 0:
		_suprimentos += new

func receive_companhias(new):
	if !_flanqueado or new < 0:
		_recem += new

# default response
func receive_message(_message):
	_message_received = _message

# GETTERS -----------------------------------------
func get_local():
	return local

func get_progresso():
	return _progresso

func get_ordem():
	return _ordem

func received_message():
	return _message_received

func set_base(new):
	base = new
	local = new.get_local()

func fim():
	_existente = false
	_progresso = -1

func recolher_suprimento():
	if _progresso < 0:
		return _supr_tabela[0]
	else:
		return _supr_tabela[_progresso+1]
