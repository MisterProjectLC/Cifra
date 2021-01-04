extends "Personagem.gd"

var _sos = false
var caiu = [0, 0, 0, 0]
var suspeito = ""

signal substituicao
signal add_opcao

func enviar_mensagens():
	if suspeito == "Weinstein":
		if caiu[0] == 0:
			enviar_pedido("Weinstein sera executado. Descobri lacos com Heimzuck...", 10)
		else:
			enviar_pedido("Lonpris caiu. Se for Weinstein, ele morreu ou escapou.", 10)
	elif suspeito == "Shelberg":
		if caiu[1] == 0:
			enviar_pedido("Shelberg? Soldado mais leal que conheco. Nao e ele.", 10)
		else:
			enviar_pedido("Arnheim caiu. De qualquer forma, nao creio que era ele.", 10)
	elif suspeito == "Mish":
		if _sos:
			enviar_pedido("Mish escapou! Enviarei uma equipe atras dele.", 10)
		elif caiu[3] == 0:
			enviar_pedido("Obrigado. Encontrei simbolo de Heimzuck, Fenix, com Mish. Ele admitiu.", 10)
		else:
			enviar_pedido("Enderburg caiu. Se for Mish, ele morreu ou escapou.", 10)
	elif suspeito == "Bardon":
		if caiu[4] == 0:
			enviar_pedido("Mike? Mike, eu... nao creio que seja ele.", 10)
		else:
			enviar_pedido("Mike... Mike morreu. Nao acho que era ele.", 10)
	
	suspeito = ""
	
	if turno == 0:
		enviar_pedido("Faremos um ataque a Lonpris as 11 da noite. Esperem o sinal.", 95, "cesar7")
	
	elif turno == 2:
		enviar_pedido("Traidor entre nos. Se perceber atitude suspeita, reporte-a para mim.", 0)
		get_node(base).visible = true
		emit_signal("add_opcao", "Aviso")
	
	elif turno == 3 and caiu[0] == 0:
		enviar_pedido("Interceptei mensagem de Lonpris. Tente decrifrar, se puder.", 5)
		enviar_pedido("Vera, nao sei o que fazer. Nao gosto dessa guerra, mas... Eles podem " +
		"me prender. Um dia, eu volto para Heimzuck, com voce. Mas ainda nao posso.", 4, "reverso")
	
	elif turno == 4 and get_node(base).visible == true and caiu[2] == 0:
		enviar_pedido("Traidor agiu. Nao enviou mensagens semana passada.", 50)
	
	elif turno == 5:
		enviar_pedido("Avioes em Toulann. 2 semanas ate ataque aereo. Voce precisa atacar antes.", 50)
	
	elif turno == 6:
		if _sos:
			enviar_pedido("SOS", 50)
		else:
			enviar_pedido("Bombardeio semana que vem. Ataque a capital agora.", 50)


func sos():
	_sos = true

func base_caiu(local):
	if local == "Lonpris":
		caiu[0] = 1
	elif local == "Arnheim":
		caiu[1] = 1
	elif  local == "Enderburg":
		caiu[2] = 1
	elif  local == "Sungarden":
		caiu[3] = 1

func traidor_saiu():
	get_node(base).visible = false

func receive_message(message):
	suspeito = message
	if message != "Shelberg" and message != "Bardon":
		emit_signal("substituicao", suspeito)
