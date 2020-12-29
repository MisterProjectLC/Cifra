extends "Soldado.gd"

func passar_turno():
	.passar_turno()
	
	enviar_pedido("AJUDA! ENVIE AJUDA!", 1)


# default response
func receive_message(message):
	ordem = message
