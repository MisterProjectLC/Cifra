extends "Personagem.gd"

var suspeito = ""

signal substituicao
signal add_opcao

func enviar_mensagens():
	if suspeito != "":
		if suspeito == "Weinstein":
			enviar_pedido("Weinstein sera executado. Descobri certos lacos com Heimzuck...", -1)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		elif suspeito == "Shelberg":
			enviar_pedido("Shelberg? Ele e o soldado mais leal que conheco...", -1)
		elif suspeito == "Mish":
			enviar_pedido("Obrigado. Mish cuspiu tudo. Enviarei Ashley Goller para Enderberg.", -1)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		elif suspeito == "Bardon":
			enviar_pedido("O Mike foi preso. Ainda nao sei se e ele...", -1)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		
		suspeito = ""
	
	if turno == 0:
		enviar_pedido("Faremos um ataque a Lonpris as 11 da noite. Procurem a luz vermelha.", 95, "cesar7")
	
	elif turno == 2:
		enviar_pedido("Temos um Traidor. Se perceber alguma atitude suspeita, reporte-a para mim.", -2)
		get_node(base).visible = true
		emit_signal("add_opcao", "Aviso")
	
	elif turno == 3 and get_node(base).visible == true:
		enviar_pedido("Interceptei uma mensagem de Lonpris. Tente decrifra-la, se puder.", 5)
		enviar_pedido("Vera, nao sei o que fazer. Nao gosto dessa guerra, mas... Eles podem " +
		"me prender. Um dia, eu volto para Heimzuck, com voce. Mas ainda nao posso.", 4, "reverso")
	
	elif turno == 4:
		enviar_pedido("O espiao agiu semana passada. Quem quer que seja, ele nao estava enviando mensagens.", 50)
		
	elif turno == 5:
		enviar_pedido("2 semanas ate ataque aereo. Voce precisa alcancar Toulann antes.", 50)


func receive_message(message):
	suspeito = message
