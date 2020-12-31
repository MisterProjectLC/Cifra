extends "Personagem.gd"

var suspeito = ""

signal substituicao
signal add_opcao

func enviar_mensagens(turno):
	if suspeito != "":
		print_debug("AA")
		if suspeito == "Mish":
			print_debug("AB")
			enviar_pedido("Obrigado, operador. Mish cuspiu tudo. Enviarei Ashley Goller para substitui-lo.", 100)
			get_node(base).visible = false
			emit_signal("substituicao", suspeito)
		
		suspeito = ""
	
	if turno == 0:
		enviar_pedido(messages[0][0], 95, "atbash")
	
	if turno == 2:
		enviar_pedido(messages[0][1], -2)
		get_node(base).visible = true
		emit_signal("add_opcao", "Aviso")


func receive_message(message):
	suspeito = message
	print_debug("TP")
