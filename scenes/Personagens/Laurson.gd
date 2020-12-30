extends "Personagem.gd"

func passar_turno(turno):
	.passar_turno(turno)
	print_debug(turno)
	if turno == 0:
		enviar_pedido(messages[0][0], 95, "cesar")
