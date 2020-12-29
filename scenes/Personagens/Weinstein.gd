extends "Soldado.gd"

func passar_turno():
	.passar_turno()
	
	enviar_pedido("Eu nao sei se posso continuar...", 0)


# default response
func receive_message(message):
	ordem = message
