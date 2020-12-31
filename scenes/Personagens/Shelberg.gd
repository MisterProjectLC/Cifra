extends "Soldado.gd"

func enviar_mensagens(turno):
	if turno >= 1:
		if _suprimentos < _companhias:
			enviar_pedido(("Soldado, mais " + str(_companhias-_suprimentos) + 
			" suprimentos!"), 1)
