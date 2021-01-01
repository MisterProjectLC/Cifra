extends "Personagem.gd"

var suspeito = ""

signal substituicao
signal add_opcao

func enviar_mensagens():
	if suspeito != "":
		if suspeito == "Weinstein":
			enviar_pedido("Weinstein sera executado. Descobri certos lacos com Heimzuck...", 100)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		elif suspeito == "Shelberg":
			enviar_pedido("Shelberg? Ele e o soldado mais leal que conheco...", 100)
		elif suspeito == "Mish":
			enviar_pedido("Obrigado. Mish cuspiu tudo. Enviarei Ashley Goller para Enderberg.", 100)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		elif suspeito == "Bardon":
			enviar_pedido("O Mike foi preso. Ainda nao sei se e ele...", 100)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		
		suspeito = ""
	
	if turno == 0:
		enviar_pedido("O acampamento em Lonpris parece ser o mais vulneravel no momento. " +
		"Faremos um ataque as 2 da madrugada.", 95, "cesar7")
	
	elif turno == 2:
		enviar_pedido("Temos um espiao entre nos. Se perceber alguma atitude suspeita, reporte-a para mim.", -2)
		get_node(base).visible = true
		emit_signal("add_opcao", "Aviso")
	
	elif turno == 4:
		enviar_pedido("O espiao agiu semana passada. Quem quer que seja, ele nao estava enviando mensagens.", 50)
		
	elif turno == 5:
		enviar_pedido("Avioes de bombardeio na capital. 2 semanas ate o ataque. Voce " +
		"precisa alcancar a cidade antes disso.", 50)


func receive_message(message):
	suspeito = message
