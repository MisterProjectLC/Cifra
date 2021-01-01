extends "Soldado.gd"

var bolado = false
signal denuncia

func enviar_mensagens():
	if turno == 2:
		if _suprimentos < _companhias:
			enviar_pedido(("Patriota, mais " + str(_companhias-_suprimentos) + 
			" suprimentos!"), 1)
	
	elif turno == 3:
		if _suprimentos < _companhias:
			enviar_pedido(("Patriota, temos bocas para alimentar! " + str(_companhias-_suprimentos) + 
			" suprimentos!"), 1)
		elif _companhias < 7:
			enviar_pedido(("Como vamos vencer sem bravos soldados? Patriota, " + str(7-_companhias) +
			" companhias!"), 1)
	
	if turno >= 4:
		if _companhias <= 2:
			enviar_pedido(("Socorro! SOCORRO! Envie mais tropas! Pelo amor de DEUS, envie mais TROPAS!"), 10)


func receive_message(message):
	.receive_message(message)
	if message == "Atacar":
		enviar_pedido(("Finalmente mais acao! Essa semana, avancaremos!!!"), 3)
	
	if message == "Recuar" and !bolado:
		enviar_pedido(("Recuar? Nunca! Vivo pela nossa nacao!"), 3)
	
	elif message == "Aviso":
		enviar_pedido(("Traidor? Voce queria ajudar o Traidor? Patriota, foi um " +
		"erro confiar em voce."), 3)
		emit_signal("denuncia")
	
	elif message == "Insistir":
		if _message_received == "Recuar" and !bolado:
			enviar_pedido(("Se meu general insiste, recuarei para ver outro dia."), 0)
	
	elif message == "Amor":
		enviar_pedido(("Amor? So pode ser o meu amor por esta grande nacao!"), 0)
	
	else:
		_ordem = message


func fim():
	.fim()
	enviar_pedido(("Oumer... OUMER! ME AJUDE, OUMER! ESTAMOS CERCADOS! ESTAMOS ACABADOS!"), 10)
