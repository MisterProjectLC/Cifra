extends "Personagem.gd"

func passar_turno(turno):
	.passar_turno(turno)
	print_debug(turno)
	if turno == 0:
		for i in range(messages[0].size()):
			enviar_pedido((messages[0][i]), 100+messages[0].size()-i, "nada")
