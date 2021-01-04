extends "Soldado.gd"

var odio = 0
var amor = false
var avisado = false
var recuado = 0
var saqueado = 0
signal abastecido
signal disco

func tomar_acoes():
	if turno >= 2:
		if _companhias <= 1 and (_ordem == "" or _ordem == "Atacar"):
			_ordem = "Recuar"
			if recuado == 0:
				recuado = 1
			enviar_pedido("Recuei meu batalhao. Caso contrario, estariamos mortos.", 2)
			odio += 1
		
		elif _companhias > 2 and _suprimentos < _companhias:
			_ordem = "Saquear"
			if saqueado == 0:
				saqueado = 1
			odio += 2


func enviar_mensagens():
	if recuado == 1:
		enviar_pedido("Recuei meu batalhao. Caso contrario, estariamos mortos.", 2)
		recuado = 2
		
	elif saqueado == 1:
		enviar_pedido(("Voce nao enviou o que precisamos. Os soldados tiveram de saquear o inimigo... " +
							"E varios morreram para isso."), 2)
		saqueado = 2
	
	if turno == 1:
		if _companhias <= 1:
			enviar_pedido(("Fomos atacados durante a madrugada! Mais tropas AGORA!"), 10)
			odio += 1
		else:
			enviar_pedido(("Obrigado pela ajuda, telegrafista. Estamos todos a salvo."), 10)
			odio -= 1
	
	elif turno == 3:
		enviar_pedido(("Pedido para " + str(max(2, 2+ (2*_companhias-_suprimentos))) + " suprimentos. " +
							"Este inverno esta especialmente rigoroso."), 1)
		if _companhias <= 2:
			enviar_pedido("Despache duas companhias, por favor.", 2)
	
	elif turno == 4:
		var ok = true
		if _suprimentos < _companhias:
			enviar_pedido(("Esta semana, " + str(2*_companhias-_suprimentos) + " suprimentos. "), 1)
			ok = false
		if _companhias <= 1:
			enviar_pedido("Estamos quase perdendo nossa posicao. Telegrafista, envie mais tropas!", 5)
			ok = false
		
		if ok and odio < 1:
			enviar_pedido(("Telegrafista, um dos batedores encontrou um disco de vinil durante uma viagem -" +
			"\"We'll Meet Again\". Semana que vem, enviarei alguem para leva-lo para voce. " +
			"Obrigado pela ajuda, telegrafista."), 1)
			odio -= 1
			emit_signal("disco")
	
	elif turno == 5:
		if _suprimentos <= _companhias:
			if odio < 1:
				enviar_pedido(("O disco chegou ai? Pedido para " + str(2*_companhias-_suprimentos) + 
								" suprimentos."), 4)
			else:
				enviar_pedido(("Pedido para " + str(2*_companhias-_suprimentos) + " suprimentos."), 3)
		
		if _companhias <= 2:
			enviar_pedido("Requisitando reforcos para Lonpris. Dois, no minimo.", 2)
	
	elif turno == 6:
		if _progresso == 2 and odio < 3:
			if amor:
				enviar_pedido(("Estou na porta de Toulann. Desde o comeco, nao sabia se iria continuar " +
				"avancando. Agora, eu sei. Pode dar a ordem."), 4)
			else:
				enviar_pedido(("Estou na porta de Toulann. Se precisar que eu avance, telegrafista... Pode dar a ordem."), 4)
		elif odio < 2:
			enviar_pedido(("Fiquei sabendo do bombardeio. Se esta for nossa ultima semana, telegrafista... " +
			"Foi bom ter te conhecido."), 0)


func receive_message(message):
	.receive_message(message)
	if message == "Aviso" and !avisado:
		avisado = true
		if odio > 0:
			enviar_pedido(("Voce... Voce realmente acha que EU sou o Traidor? " +
					"Eu faco parte dessa guerra porque e meu dever. E so isso." +
					"Mas eu nao iria trair o pais desse jeito."), -1)
			odio += 3
		else:
			enviar_pedido(("Heh, nao, nao sou esse Traidor que voce procura, mas entendo " + 
			"porque pensaria isso. Obrigado, de qualquer forma."), -1)
	
	elif message == "Amor" and !amor:
		if odio >= 3:
			enviar_pedido(("...Maldito. Escuta, eu tenho uma familia la, sim. Mas " +
			"nao fale sobre isso para ninguem. Eles podem me prender, ou... pior."), -1)
		else:
			enviar_pedido(("Ah. Entao voce sabe... Sim, antes da guerra, eu morava em Heimzuck " +
			"com minha esposa. Agora... honestamente, eu nao sei o que fazer. Nenhum dos lados " +
			"parece justo para mim. De qualquer forma, eu continuo aqui."), -1)
		amor = true
	
	elif message == "Insistir":
		return
	
	elif odio >= 3:
		enviar_pedido(("Nao. Nao tomo mais ordens de voce."), -1)
	
	else:
		_ordem = message


func receive_suprimentos(new):
	.receive_suprimentos(new)
	
	if new > 0:
		emit_signal("abastecido")


func receive_companhias(new):
	.receive_companhias(new)


func fim():
	.fim()
	if odio < 2:
		if turno > 2:
			enviar_pedido(("Telegrafista... estamos cercados. Foi bom te conhecer. Boa sorte."), 10)
		else:
			enviar_pedido(("Telegrafista... estamos cercados. Lonpris caiu."), 10)
	else:
		enviar_pedido(("Estarei morto em alguns momentos. Ainda tenho refugio no fato de " +
		"que Lonpris voltara para as maos de Heimzuck. Adeus."), 10)
