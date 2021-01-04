extends "Personagem.gd"

var tarefa_feita = false
var tera_ataque_duplo = false
var strikes = 0
var caiu = [0, 0, 0, 0]

signal incompetente

func enviar_mensagens():
	if turno == 0:
		for i in range(messages[0].size()):
			enviar_pedido((messages[0][i]), 100+messages[0].size()-i, "nada")
	
	elif turno == 1:
		enviar_pedido(("Soldado: avance Lonpris. Se precisar, envie reforcos."), 100)
	
	elif turno == 2 and caiu[3] == 0:
		enviar_pedido(("Soldado: avance Sungarden. Envie tropas para la, tambem. " +
		"Aquela posicao e rica em suprimentos."), 100)
		if tarefa_feita:
			enviar_pedido(("Bom trabalho em Lonpris, soldado."), 101)
		else:
			strikes += 1
			enviar_pedido(("Lonpris nao avancou. Nao me desafie, soldado."), 101)
	
	elif turno == 3:
		enviar_pedido(("Soldado: nosso objetivo sera Toulann, capital de Heimzuck. " +
		"Algum fronte precisa avancar 3 posicoes."), 100)
		if tarefa_feita:
			enviar_pedido(("Bom trabalho, soldado. Nossa linha de recursos esta assegurada."), 101)
		else:
			strikes += 1
			enviar_pedido(("Sungarden nao avancou. Nao me desafie, soldado."), 101)
	
	elif turno == 4:
		if caiu[3] == 0 and caiu[1] == 0:
			enviar_pedido(("Soldado: avance Sungarden e Arnheim. Ambos " +
				"precisam atacar, ou isso nao dara certo."), 100)
			tera_ataque_duplo = true
		else:
			if caiu[1] != 0:
				enviar_pedido(("Shelberg... Shelberg caiu em batalha? Nao acredito... " +
				"nunca antes houve batalha em que ele perdeu assim."), 100)
				strikes += 1
			if caiu[3] != 0:
				enviar_pedido(("Sungarden caiu?! Perder esse territorio tera grandes " +
				"repercussoes para nosso futuro."), 100)
				strikes += 1
	
	elif turno == 5:
		if caiu[0] == 0 and caiu[1]+caiu[2]+caiu[3] < 2:
			enviar_pedido(("Soldado: nao precisamos mais de Lonpris. Corte o abastecimento para aquela " +
						"posicao."), 100)
		if tarefa_feita:
			enviar_pedido(("Bom trabalho, soldado. O ataque obteve sucesso."), 101)
		else:
			strikes += 1
			if tera_ataque_duplo:
				enviar_pedido(("O ataque falhou."), 101)
	
	elif turno == 6:
		if tarefa_feita:
			strikes += 1
		enviar_pedido(("Soldado: hoje e o dia. Precisamos invadir Toulann nesta semana, ou este fronte " +
		"caira."), 100)
	
	if strikes >= 4:
		emit_signal("incompetente")
	tarefa_feita = false


func base_caiu(local):
	if local == "Lonpris":
		caiu[0] = 1
	elif local == "Arnheim":
		caiu[1] = 1
	elif  local == "Enderburg":
		caiu[2] = 1
	elif  local == "Sungarden":
		caiu[3] = 1


func fazer_tarefa():
	tarefa_feita = true


func enviar_goller():
	enviar_pedido(("Recebemos a noticia sobre o Traidor. Enviarei Ashley Goller, uma das nossas " +
	"melhores, como substituta."), 100)
