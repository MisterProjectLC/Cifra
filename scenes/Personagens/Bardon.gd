extends "Soldado.gd"

func enviar_mensagens(turno):
	if turno >= 1:
		if _suprimentos < 2:
			enviar_pedido("Precisamos urgentemente de mais suprimentos!", 4)
		elif _suprimentos < _companhias:
			enviar_pedido(("Estamos faltando " + str(_companhias-_suprimentos) + 
			" suprimentos."), 1)
