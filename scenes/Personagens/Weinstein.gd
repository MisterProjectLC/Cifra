extends "Soldado.gd"

func passar_turno(turno):
	.passar_turno(turno)
	
	if turno >= 1:
		if suprimentos < companhias:
			enviar_pedido(str(companhias-suprimentos) + " suprimentos para Toulann.", 1)


# default response
func receive_message(message):
	ordem = message
