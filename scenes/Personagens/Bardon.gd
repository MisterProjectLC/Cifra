extends "Soldado.gd"

var enviado = 0
var avisado = false
var amor = false
var tentou_atacar = false
var tentou_saquear = false
var atacou = false
var emboscado = false
var sos = false

func ataque_falho():
	emboscado = true

func enviar_mensagens():
	if emboscado:
		enviar_pedido(("De alguma forma, o inimigo ja sabia do nosso ataque. Nao conseguimos tomar a posicao."), 10)
		_progresso -= 1
		atacou = true
		emboscado = false
		
	elif _ordem == "Atacar" and !atacou:
		enviar_pedido(("Nao tivemos tantas baixas quanto esperado, mas... nao consegui salvar todos."), 1)
		atacou = true
	
	if turno == 1:
		enviar_pedido("Alo? Mike Bardon falando. Peco 2 suprimentos para tratar os feridos.", 2)
	
	elif turno == 2:
		if enviado:
			if _suprimentos < 2*_companhias:
				enviar_pedido(("Os suprimentos chegaram. Bom trabalho. Hoje, precisamos de mais " + 
						str(2*_companhias-_suprimentos) + "."), 2)
			else:
				enviar_pedido(("Os suprimentos chegaram. Bom trabalho."), 0)
		else:
			enviar_pedido(("Cara da torre? VOCE NAO OUVIU? " + str(2*_companhias-_suprimentos) + 
					"SUPRIMENTOS, AGORA. SOLDADOS ESTAO MORRENDO."), 10)
	
	elif turno == 3:
		if enviado == 2:
			if tentou_atacar:
				enviar_pedido(("Obrigado, cara da torre. Eu sei que voce tem seu trabalho, mas eu " +
			" nao vou dar ordens de ataque. Pela minha honra de medico, entende?"), 0)
			else:
				enviar_pedido(("Obrigado, cara da torre. Caso aconteca algo, saiba disso - nao " +
			"vou aceitar ordens de ataque. Pela minha honra de medico, entende?"), 0)
		elif 2*_companhias > _suprimentos:
			if enviado >= 1:
				enviar_pedido(("Cara da torre, ainda precisamos de suprimentos. Envie " + 
					str(2*_companhias-_suprimentos)) + ".", 0)
			else:
				enviar_pedido(("Envie " + str(2*_companhias-_suprimentos)) + " suprimentos.", 0)

	elif turno == 4:
		if _suprimentos < 2*_companhias:
			enviar_pedido(("Precisamos de mais " + str(2*_companhias-_suprimentos) +
						" suprimentos."), 3)
		if _companhias <= 2:
			enviar_pedido(("Para manter nossa posicao, precisamos de mais 3 companhias, no minimo."), 2)
	
	elif turno == 5:
		if enviado == 2 and sos:
			enviar_pedido(("Poderia dar uma olhada se o Ken ainda ta bem? " +
			"Faz tempo que ele nao se comunica com o acampamento..."), 0)
		
		if _suprimentos < _companhias:
			enviar_pedido(("Cara da torre! Precisamos de medicamentos! Envie " + str(_companhias-_suprimentos) + "!"), 3)
		if _companhias <= 2:
			enviar_pedido(("Envie mais 2 companhias!"), 2)
	
	elif turno == 6:
		if _progresso == 2:
			enviar_pedido(("Estou vendo os avioes em Toulann. Normalmente eu seria contra, mas... Se for " +
			"necessario, eu posso atacar. So de a ordem e envie o que puder."), 4)
		else:
			enviar_pedido(("Sofremos uma emboscada! Envie mais companhias, por favor!"), 4)


func receive_suprimentos(new):
	.receive_suprimentos(new)
	if turno <= 4 and new >= 2:
		enviado += 1


func receive_message(message):
	.receive_message(message)
	if message == "Atacar":
		if turno == 6 and _progresso == 2:
			enviar_pedido(("Entendido. Se esta for minha morte... adeus."), -1)
			_ordem = message
		elif !tentou_atacar:
			enviar_pedido(("Nao avancaremos. Nao tomaremos parte na vinganca coletiva dessa nacao."), -1)
			tentou_atacar = true
		elif _ordem != "Atacar":
			enviar_pedido(("Voce sabe que eu nao quero atacar."), -1)

	elif message == "Saquear":
		if !tentou_saquear:
			tentou_saquear = true
			enviar_pedido(("Saquear..? Sera um pouco perigoso, mas... tudo bem, eu entendo."), -1)
		_ordem = message

	elif message == "Aviso":
		if !avisado:
			enviar_pedido(("Fugir? O Ken... Nao, ele nao faria isso. Nao gosto dessa " +
					"guerra, mas as tropas precisam de um medico."), -1)
			avisado = true
	
	elif message == "Insistir":
		if _message_received == "Atacar":
			if enviado == 0:
				enviar_pedido(("NAO. Por causa de voce, nossas tropas estao mortas e feridas. Nao vamos avancar."), -1)
			else:
				_ordem = _message_received
				enviar_pedido(("...Tudo bem. O sangue estara nas suas maos, mas eu avanco."), -1)
				enviado -= 1
		
		elif _message_received == "Amor":
			if enviado < 2:
				enviar_pedido(("Tudo bem. Voce quer me ver na forca? Sim, eu admito. " +
					"Eu... Sim, eu... Eu amo ele."), -1)
	
	elif message == "Amor":
		if amor:
			return
		amor = true
		
		if enviado >= 2:
			enviar_pedido(("...Escuta. Eu conheco o Ken... desde ha muito tempo. E... sim, " +
			"eu admito. Existem momentos... em que percebo... que eu... eu... eu amo ele."), -1)
		else:
			enviar_pedido(("Eu nao sei do que voce ta falando. Nao comente mais disso."), -1)
	
	else:
		_ordem = message


func sos():
	sos = true


func fim():
	.fim()
	enviar_pedido(("...Cheguei ao fim da linha. Estaremos mortos em pouco tempo. Boa noite."), 10)
