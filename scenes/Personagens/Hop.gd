extends "Personagem.gd"

func enviar_mensagens(turno):
	if turno == 0:
		for i in range(messages[0].size()):
			enviar_pedido((messages[0][i]), 100+messages[0].size()-i, "nada")
