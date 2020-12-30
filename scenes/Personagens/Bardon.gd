extends "Soldado.gd"

func passar_turno(turno):
	.passar_turno(turno)
	
	if turno >= 1:
		if suprimentos < 2:
			enviar_pedido("Precisamos urgentemente de mais suprimentos!", 4)
		elif suprimentos < companhias:
			enviar_pedido("Estamos faltando " + str(companhias-suprimentos) + " suprimentos.", 1)


# default response
func receive_message(message):
	ordem = message
