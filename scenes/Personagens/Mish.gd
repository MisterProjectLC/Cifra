extends "Soldado.gd"

var errei = false
var amor = false
var escapando = false
signal escape

func tomar_acoes():
	if escapando:
		emit_signal("escape")
		return
	
	# jogando fora
	if turno >= 1 and _suprimentos > _companhias+3:
		_suprimentos = _companhias+3
	
	if turno == 6:
		enviar_pedido(("ALO? HARRY NICHOLS FALANDO! ISAAC MISH NOS LEVOU A UMA EMBOSCADA! " +
		"ENVIE SUPORTE! POR FAVOR, ENVIE SJVMBPAK"), 150)
		_companhias = 0
		_suprimentos = 0


func enviar_mensagens():
	if turno == 1:
		enviar_pedido("Boa tarde, operador. 3 suprimentos, por favor.", 4)
	
	elif turno == 2:
		if _suprimentos < _companhias:
			enviar_pedido(("Alo? Voce nao enviou os suprimentos que pedi. Deve ter sido " +
							"apenas um engano... pode envia-los, por favor?"), 4)
		else:
			enviar_pedido(("Operador? Obrigado pela ajuda, de verdade."), 4)
		enviar_pedido(("Bom dia, operador. Por favor, pode enviar mais companhias? " +
						"Quatro servem."), 2)
	
	elif turno == 4:
		enviar_pedido(("Tenho informacoes importantes - Arnheim sera emboscada." + 
			"Faca-a recuar, por favor."), 15)
		if _suprimentos < _companhias:
			enviar_pedido(("Precisamos urgentemente de suprimentos. " +
			str(3+_companhias-_suprimentos) + ", no minimo."), 4)
	
	elif turno == 5:
		enviar_pedido(("Estamos proximos de Toulann! Operador, envie tudo o que puder." +
		"Vamos encerrar com isso agora!"), 20)


func receive_suprimentos(new):
	.receive_suprimentos(new)
	
	if turno == 1 and new <= 4 and !errei:
		enviar_pedido("Perdao, errei. " + str(new+1) + " suprimentos, na verdade.", -1)
		errei = true
	
	if turno == 4 and new > 0:
		enviar_pedido("Obrigado, operador.", -1)


func receive_message(message):
	if turno == 3:
		return
	.receive_message(message)
	
	if message == "Aviso":
		enviar_pedido(("...Entendido. Obrigado, operador. Se sua torre cair para nossas forcas, " +
					"avisarei para te pouparem. Pela Fenix!"), -1)
		escapando = true
	
	elif message == "Amor" and !amor:
		enviar_pedido(("Amor? Do que voce ta falando?"), -1)
		amor = true
	
	elif message == "Insistir":
		return
	
	else:
		_ordem = message
