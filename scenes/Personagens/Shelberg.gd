extends "Soldado.gd"

func passar_turno(turno):
	.passar_turno(turno)
	
	if turno >= 1:
		if suprimentos < companhias:
			enviar_pedido("Soldado, mais " + str(companhias-suprimentos) + " suprimentos!", 1)


# default response
func receive_message(message):
	ordem = message
