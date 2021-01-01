extends "Soldado.gd"

var estado = 0

signal abastecido

func tomar_acoes():
	if turno >= 2:
		if _companhias <= 1 and _ordem == "" or _ordem == "Atacar":
			_ordem = "Recuar"
			estado = 1
		
		if estado == 3:
			if _companhias > 2 and _suprimentos < _companhias:
				_ordem = "Saquear"
				enviar_pedido(("Voce nao enviou nada. Os soldados tiveram de saquear as casas. " +
							"E eu... eu encontrei minha casa antiga aqui. Revirada. Por sua causa."), 2)
			else:
				_ordem = "Recuar"


func enviar_mensagens():
	if turno == 1:
		if _companhias <= 1:
			enviar_pedido(("Fomos atacados durante a madrugada! " +
				"Mais soldados AGORA!"), 10)
		else:
			enviar_pedido(("Obrigado pela ajuda, telegrafista. Estamos todos a salvo."), 10)
	
	elif turno == 2:
		if _suprimentos <= _companhias:
			enviar_pedido(str(2*_companhias-_suprimentos) + " suprimentos para Lonpris.", 1)
		if _companhias <= 2:
			enviar_pedido("Precisamos de 3 companhias aqui em Lonpris. Sofremos baixas.", 2)
	
	elif turno == 3:
		if _suprimentos <= _companhias:
			enviar_pedido(("Envie " + str(2*_companhias-_suprimentos) + " suprimentos. " +
							"Este inverno esta especialmente rigoroso."), 1)
		if _companhias <= 1:
			enviar_pedido("Estamos quase perdendo nossa posicao. Envie mais soldados.", 2)


	if turno >= 2:
		if estado == 1:
			enviar_pedido("Recuei meu batalhao. Caso contrario, estariamos mortos.", 2)
			estado = 2

func receive_message(message):
	.receive_message(message)
	if estado == 3:
		enviar_pedido(("Nao. Nao tomo mais ordens de voce."))
	
	elif message == "Aviso":
		enviar_pedido(("Voce... Voce realmente acha que EU sou o Traidor? " +
					"Eu faco parte dessa guerra porque e meu dever. E so isso." +
					"Mas eu nao iria trair o pais desse jeito."))
		estado = 3
	
	else:
		_ordem = message


func receive_suprimentos(new):
	.receive_suprimentos(new)
	
	if turno >= 5 and new > 0:
		emit_signal("abastecido")


func fim():
	.fim()
	if estado == 2:
		enviar_pedido(("Ei, telegrafista... estamos cercados. Foi bom te conhecer. Boa sorte."), 10)
	else:
		enviar_pedido(("Estarei morto em alguns momentos. Ainda tenho refugio no fato de " +
		"que Lonpris voltara para as maos de Heimzuck. Adeus."), 10)
