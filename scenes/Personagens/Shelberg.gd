extends "Soldado.gd"

var bolado = false
var amor = false
signal denuncia

func enviar_mensagens():
	if turno == 2:
		if _suprimentos < _companhias:
			enviar_pedido(("Patriota, mais " + str(_companhias-_suprimentos) + 
			" suprimentos!"), 1)
	
	elif turno == 3:
		if _suprimentos < _companhias:
			enviar_pedido(("Patriota, temos bocas para alimentar! " + str(2*_companhias-_suprimentos) + 
			" suprimentos!"), 1)
		if _companhias < 7:
			enviar_pedido(("Como vamos vencer sem soldados? Patriota, " + str(7-_companhias) +
			" companhias!"), 1)
		
	elif turno == 4:
		if _suprimentos < _companhias:
			enviar_pedido(("Mais " + str(2*_companhias-_suprimentos) + " suprimentos!"), 1)
	
	elif turno == 5:
		if _companhias > 2 and _companhias < 7:
			enviar_pedido(("Tropas! Envie mais tropas!"), 1)
		elif _companhias >= 7 and !bolado:
			enviar_pedido(("Faca Heimzuck sangrar! Mande-nos avancar!"), 1)
	
	elif turno == 6:
		if bolado:
			enviar_pedido(("Estamos sangrando... feridos... envie ajuda!"), 1)
		elif _progresso == 2:
			enviar_pedido("Patriota, estamos na porta de Toulann! VAMOS AVANCAR!!", 10)
	
	if turno >= 4:
		if _companhias <= 2:
			enviar_pedido(("Socorro! SOCORRO! Envie mais tropas! Pelo amor de DEUS, envie mais TROPAS!"), 10)
			bolado = true


func receive_message(message):
	.receive_message(message)
	if message == "Atacar":
		if bolado:
			enviar_pedido(("N-Nao! Por favor, nao quero mais avancar!"), -1)
		else:
			enviar_pedido(("Finalmente mais acao! Essa semana, avancaremos!!!"), -1)
			_ordem = message
	
	if message == "Recuar" and !bolado:
		enviar_pedido(("Recuar? Nunca! Vivo pela nossa nacao!"), -1)
	
	elif message == "Aviso":
		if !bolado:
			enviar_pedido(("Traidor? Voce queria ajudar o Traidor? Patriota, foi um " +
				"erro confiar em voce."), -1)
			emit_signal("denuncia")
		else:
			enviar_pedido(("F-Fugir? Eu..."), -1)
	
	elif message == "Insistir":
		if _message_received == "Recuar" and !bolado:
			enviar_pedido(("Se meu general insiste, recuarei para ver outro dia."), -1)
	
	elif message == "Amor" and !amor and !bolado:
		enviar_pedido(("Amor? So pode ser o meu amor por esta grande nacao!"), -1)
		amor = true
	
	else:
		_ordem = message


func fim():
	.fim()
	enviar_pedido(("Oumer... OUMER! ME AJUDE, OUMER! ESTAMOS CERCADOS! ESTAMOS ACABADOS!"), 10)
