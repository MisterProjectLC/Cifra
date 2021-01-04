extends "Soldado.gd"

var bolado = false
var amor = false
var atacou = false
signal denuncia


func enviar_mensagens():
	if turno >= 4 and _companhias == 1 and !bolado:
		enviar_pedido(("Socorro! SOCORRO! Envie mais homens! Pelo amor de DEUS, envie mais HOMENS!"), 10, "nada")
		bolado = true
	elif _ordem == "Atacar" and !atacou:
		enviar_pedido(("VITORIA! Estamos a caminho para a capital de Heimzuck!"), 1)
		atacou = true
	
	if turno == 2:
		if _suprimentos < 2*_companhias:
			enviar_pedido(("Patriota! Envie " + str(2*_companhias-_suprimentos) + " suprimentos!"), 1)
	
	elif turno == 3:
		if _suprimentos < _companhias:
			enviar_pedido(("Nao ouviu? SUPRIMENTOS! Eu sou RICARDO SHELBERG!"), 4)
		else:
			enviar_pedido(("Patriota, envie mais homens! Sozinho, venco esta guerra!"), 2)
		
	elif turno == 4:
		if _suprimentos < _companhias:
			if !bolado:
				enviar_pedido(("Patriota, temos bocas para alimentar! " + str(2*_companhias-_suprimentos) + 
							" suprimentos!"), 1)
			else:
				enviar_pedido(("Mande TODOS OS SUPRIMENTOS! ESQUECA O RESTO, MANDE TUDO!"), 10)
		
		elif _companhias >= 6 and !bolado:
				enviar_pedido(("Faca Heimzuck sangrar! Mande-nos avancar!"), 1)
	
	elif turno == 5:
		if _suprimentos < _companhias:
			if !bolado:
				enviar_pedido(("Patriota, eu preciso de racoes, armas, medicamentos! Envie " + 
				str(2*_companhias-_suprimentos) + "!"), 1)
			else:
				enviar_pedido(("Eu preciso de RACOES. ARMAS. MEDICAMENTOS. Envie tudo o que tiver!"), 1)
		
		if _companhias > 2 and _companhias < 7 and !bolado:
			enviar_pedido(("Como vamos vencer sem soldados? Patriota, " + str(7-_companhias) +
					" companhias de homens bem treinados!"), 1)
		
	
	elif turno == 6:
		if bolado:
			enviar_pedido(("EU SOU SHELBERG! RICARDO SHELBERG! MEU NOME NAO VALE NADA? MANDE. TUDO!"), 10, "nada")
		elif _progresso == 2:
			enviar_pedido("Patriota, estamos na porta de Toulann! MANDE TUDO E VAMOS AVANCAR!!", 10)
		else:
			enviar_pedido("Nao vejo Toulann... Droga! Nao avance ainda! Eu quero estar la!", 10)


func receive_message(message):
	.receive_message(message)
	if message == "Atacar":
		if bolado:
			enviar_pedido(("Nao! Ainda... Ainda nao e a hora de atacar!"), -1, "nada")
		elif !atacou:
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
			enviar_pedido(("F-Fugir? Eu... Eu nao sei o que fazer..."), -1)
	
	elif message == "Insistir":
		if _message_received == "Recuar" and !bolado:
			enviar_pedido(("Se meu general insiste, recuarei para ver outro dia."), -1)
			_ordem = _message_received
		elif _message_received == "Atacar" and bolado:
			if _companhias < 5:
				enviar_pedido(("Eu... Nao! Nao, eu nao posso!"), -1, "nada")
			else:
				enviar_pedido(("...Tudo bem. Tudo bem, por Oumer, eu avanco."), -1)
				_ordem = _message_received
	
	elif message == "Amor" and !amor:
		if !bolado:
			enviar_pedido(("Amor? So pode ser o meu amor por esta grande nacao!"), -1)
		else:
			enviar_pedido(("Que? Nao sei do que fala!"), -1)
		amor = true
	
	else:
		_ordem = message


func fim():
	.fim()
	enviar_pedido(("Oumer... OUMER! ME AJUDE, OUMER! EU SOU SHELBERG! NAO ERA PARA SER ASSIM! ESTAMOS CERCADOS!"), 10, "nada")
