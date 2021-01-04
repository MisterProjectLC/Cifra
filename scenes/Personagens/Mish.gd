extends "Soldado.gd"

var errei = false
var amor = false
var aviso_ataque = 0
signal escape

func tomar_acoes():
	if turno == 6:
		enviar_pedido(("ALO? HARRY NICHOLS FALANDO! ISAAC MISH NOS LEVOU A UMA EMBOSCADA! " +
		"ENVIE SUPORTE! POR FAVOR, ENV"), 150, "nada")
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
			enviar_pedido(("Operador, algum ataque para hoje? Podemos " +
			"ajudar na ofensiva, se voce der a ordem."), 4)
			aviso_ataque = 1
	
	elif turno == 4:
		enviar_pedido(("Tenho informacoes importantes - Arnheim sera emboscada. " + 
			"Faca-a recuar, por favor."), 15)
		
		enviar_pedido(("Precisamos urgentemente de suprimentos e tropas. " +
			str(3+_companhias) + " e " + "3, respectivamente, por favor."), 4)
	
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
	
	if message == "Atacar":
		if turno == 2 and aviso_ataque == 1:
			aviso_ataque = 2
		return
	
	if message == "Aviso":
		enviar_pedido(("...Entendido. Obrigado, operador. Se sua torre cair para nossas forcas, " +
					"avisarei para te pouparem. Pela Fenix!"), -1)
		emit_signal("escape")
	
	elif message == "Amor" and !amor:
		enviar_pedido(("Amor? Do que voce esta falando?"), -1)
		amor = true
	
	elif message == "Insistir":
		return
	
	else:
		_ordem = message


func get_aviso_ataque():
	return (aviso_ataque == 2)
