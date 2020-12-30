extends Control

var clock_max = 30
var intervalo = 15

var modo_envio = false
var estoque_supr
var estoque_comp
var delta_supr
export var delta_comp = 3

var semana
var finais

# START ------------------------------------------------
func _ready():
	semana = -1
	finais = Parser.load_file("finais")
	atualizar_estoque(0, 0)
	passar_turno()


func _on_Menu_start_game():
	visible = true
	$FadeIn.introd_text(Parser.load_file("introd")[0])


func _on_FadeIn_done():
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()
	if semana == 0:
		$NovaMensagem.wait_time = 10
		$NovaMensagem.start()
		$Turno.wait_time = 180
	else:
		$NovaMensagem.wait_time = 30
		$NovaMensagem.start()
		$Turno.wait_time = 240
	
	$Timer.start()
	$Turno.start()

# TIMERS --------------------------------------
func _on_Timer_timeout():
	$Relogio.relogio()

func _on_NovaMensagem_timeout():
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()

func _on_Turno_timeout():
	passar_turno()


# PASSAR TURNO -------------------------------------------
func passar_turno():
	semana += 1
	if checar_final():
		return
	
	$Recebimento/Pedidos/PedidosManager.limpar_pedidos()
	delta_supr = 0
	for personagem in $Personagens.get_children():
		personagem.passar_turno(semana)
		if personagem.has_method("recolher_suprimento"):
			delta_supr += personagem.recolher_suprimento()
	
	atualizar_estoque(estoque_supr + delta_comp, estoque_comp + delta_supr)
	
	if semana:
		$FadeIn.turn_text(semana)


func checar_final():
	if semana > 6:
		return true
	
	for personagem in $Personagens.get_children():
		if personagem.has_method("get_progresso") and personagem.get_progresso() >= 3:
			return true
	
	return false

# SIGNAL HANDLING -------------------------------------------

func _on_Relogio_tempo_esgotado():
	passar_turno()


func atualizar_estoque(suprimentos, companhias):
	estoque_supr = suprimentos
	estoque_comp = companhias
	
	$Envio/Estoque/Label.text = ("ESTOQUE\n" + 
			str(estoque_supr) + "x Suprimentos\n" + 
			"(+" + str(delta_supr) + "x no último\nturno)\n\n" + 
			str(estoque_comp) + "x Companhias\n" +
			"(+" + str(delta_comp) + "x por turno)")
	
	$Envio/Painel/PainelTexto.atualizar_maximo(estoque_supr, estoque_comp)


func novo_pedido(nome, cripto, texto, prioridade):
	$Recebimento/Pedidos/PedidosManager.novo_pedido(nome, cripto, texto, prioridade)

func pedido_acessado(cripto, texto):
	$Recebimento/Mensagem/Label.text = Codificador.codificar(texto, cripto)

func _on_Troca_button_up():
	modo_envio = !modo_envio
	$Recebimento.visible = !modo_envio
	$Envio.visible = modo_envio
	if modo_envio:
		$Troca/Label.text = "RECEBER"
	else:
		$Troca/Label.text = "ENVIO"


func _on_PainelTexto_envio_mensagem(nome_atual, msg_atual):
	if $Personagens.has_node(nome_atual):
		$Personagens.find_node(nome_atual).receive_message(msg_atual)

func _on_PainelTexto_envio_recursos(nome_atual, suprimentos, companhias):
	if $Personagens.has_node(nome_atual):
		atualizar_estoque(estoque_supr-suprimentos, estoque_comp-companhias)
		$Personagens.find_node(nome_atual).receive_suprimentos(suprimentos)
		$Personagens.find_node(nome_atual).receive_companhias(companhias)


# PAUSE MENU -----------------------------
func _on_Pausar_button_up():
	get_tree().paused = true
	$AnimationPlayer.play("PauseMenu")

func _on_Continuar_button_up():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("PauseMenu")

func _on_Menu_button_up():
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Sair_button_up():
	get_tree().quit()
