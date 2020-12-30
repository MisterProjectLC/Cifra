extends "Soldado.gd"

func passar_turno(turno):
	.passar_turno(turno)
	
	# jogando fora
	if suprimentos > companhias:
		suprimentos = companhias
	
	if turno >= 1:
		if suprimentos < companhias:
			enviar_pedido("Precisamos de " + str(companhias-suprimentos) + " suprimentos.", 1)


# default response
func receive_message(message):
	ordem = message
