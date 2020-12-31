extends "Soldado.gd"

func tomar_acoes(_turno):
	# jogando fora
	if _suprimentos > _companhias:
		_suprimentos = _companhias

func enviar_mensagens(turno):
	if turno >= 1:
		if _suprimentos < _companhias:
			enviar_pedido("Precisamos de " + str(_companhias-_suprimentos) + " suprimentos.", 1)
