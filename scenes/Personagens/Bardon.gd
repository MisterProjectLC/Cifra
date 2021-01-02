extends "Soldado.gd"

var enviado = 0
var avisado = false
var tentou_atacar = false

func tomar_acoes():
	if turno >= 1:
		if _ordem == "Atacar":
			_ordem = ""

func enviar_mensagens():
	if turno == 1:
		enviar_pedido("Alo? Mike Bardon falando. Peco 5 suprimentos para tratar os feridos.", 2)
	
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
		elif enviado == 1:
			enviar_pedido(("Cara da torre, ainda precisamos de suprimentos. Envie " + 
					str(2*_companhias-_suprimentos)) + ".", 0)

	elif turno == 4:
		if _suprimentos < 2*_companhias:
			enviar_pedido(("Precisamos de mais " + str(2*_companhias-_suprimentos) +
						"suprimentos."), 3)
		if _companhias <= 2:
			enviar_pedido(("Para manter nossa posicao, precisamos de mais 3 companhias, no minimo."), 2)


func receive_suprimentos(new):
	.receive_suprimentos(new)
	if turno <= 2 and new >= 5:
		enviado += 1


func receive_message(message):
	.receive_message(message)
	if message == "Atacar":
		if !tentou_atacar:
			enviar_pedido(("Nao avancaremos. Nao tomaremos parte na vinganca coletiva dessa nacao."), -1)
			tentou_atacar = true

	elif message == "Aviso":
		if !avisado:
			enviar_pedido(("Fugir? O Ken... Nao, ele nao faria isso. Nao gosto dessa " +
					"guerra, mas as tropas precisam de um medico."), -1)
			avisado = true
	
	elif message == "Insistir":
		if _message_received == "Atacar":
			if enviado == 2:
				enviar_pedido(("...Tudo bem. O sangue estara nas suas maos, mas eu avanco."), -1)
			else:
				enviar_pedido(("NAO. Por causa de voce, nossas tropas estao mortas e feridas. Nao vamos avancar."), -1)
		
		elif _message_received == "Amor":
			if enviado < 2:
				enviar_pedido(("Tudo bem. Voce quer me ver na forca? Sim, eu admito. " +
					"Eu... Sim, eu... Eu amo ele."), -1)
	
	elif message == "Amor":
		if enviado == 2:
			enviar_pedido(("...Escuta. Eu conheco o Laurson... desde ha muito tempo."), -1)
		else:
			enviar_pedido(("Eu nao sei do que voce ta falando. Nao comente mais disso."), -1)
	
	else:
		_ordem = message


func fim():
	.fim()
	enviar_pedido(("...Cheguei ao fim da linha. Estaremos mortos em pouco tempo. Boa noite."), 10)
