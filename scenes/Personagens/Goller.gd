extends "Soldado.gd"

var introducao = false
var amor = false
var saqueou = 0

func tomar_acoes():
	if _suprimentos < _companhias and _companhias > 2:
		_ordem = "Saquear"
		if saqueou == 0:
			saqueou = 1

func enviar_mensagens():
	if !introducao:
		enviar_pedido("Saudacoes. Sou Ashley Goller. Vim substituir o antigo comandante. " +
		"Envie tudo o que eu precise e eu vencerei esta guerra.", 10)
		_progresso += 1
		introducao = true
	
	elif saqueou == 1:
		enviar_pedido(("Idiota, voce nao enviou o que eu precisava. Soldados morreram para "+
				"nos sustentar."), 15)
		saqueou = 2
	
	if _suprimentos < _companhias:
		var para_enviar
		if turno == 6:
			para_enviar = _companhias-_suprimentos
		else:
			para_enviar = 2*_companhias-_suprimentos
		
		if saqueou == 0:
			enviar_pedido(str(para_enviar) + " suprimentos. " +
					"Envie imediatamente.", 3)
		else:
			enviar_pedido(str(para_enviar) + " suprimentos. " +
					"Envie certo, dessa vez.", 3)
	
	if _progresso == 2:
		enviar_pedido("Estou vendo Toulann daqui. Envie soldados e de a ordem. Vou transformar essa cidade em ruinas.", 10)
	elif _companhias < 5:
		enviar_pedido("Envie 3 companhias, no minimo. Estamos com falta de soldados.", 3)
	else:
		enviar_pedido("Podemos avancar. De a palavra e nos atacamos.", 3)



func receive_message(message):
	.receive_message(message)
	
	if message == "Recuar" and _companhias >= 5:
		enviar_pedido(("Recuar? AGORA? Voce tem problema?"), -1)
	
	elif message == "Insistir" and _message_received == "Recuar" and _companhias >= 5:
		enviar_pedido(("...Tudo bem. Nao vou arriscar uma corte marcial por uma nacao de idiotas."), -1)
		_ordem = _message_received
	
	elif message == "Amor" and !amor:
		enviar_pedido(("Amor...? Voce e um idiota, sabia? Cala a boca."), -1)
		amor = true
	
	else:
		_ordem = message


func fim():
	.fim()
	enviar_pedido(("O exercito foi rodeado. ...Eu perdi. " + str(local) + " caiu."), 10)
