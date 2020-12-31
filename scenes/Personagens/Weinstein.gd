extends "Soldado.gd"

var proativo = false
var faltando = [0, 0]

func tomar_acoes(turno):
	if turno >= 2:
		if _companhias <= 1 and _ordem == "" or _ordem == "Atacar":
			_ordem = "Recuar"
			proativo = true


func enviar_mensagens(turno):
	if turno == 1:
		if _companhias <= 1:
			enviar_pedido(("Fomos atacados durante a madrugada! " +
				"Mais soldados AGORA!"), 10)
	
	elif turno >= 2:
		if proativo:
			enviar_pedido("Recuei meu batalhao. Caso contrario, estariamos mortos.", 2)
		if _suprimentos < _companhias:
			enviar_pedido(str(_companhias-_suprimentos) + " suprimentos para Lonpris, por favor.", 1)
		if _companhias <= 2:
			enviar_pedido("2 companhias para Lonpris, por favor.", 2)
