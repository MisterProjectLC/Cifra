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

export(PackedScene) var goller

# START ------------------------------------------------
func _ready():
	for personagem in $Personagens.get_children():
		personagem.connect("enviar_pedido", self, "novo_pedido")
	
	semana = -1
	finais = Parser.load_file("finais")
	atualizar_estoque(0, 0)
	passar_turno()


func _on_Menu_start_game():
	visible = true
	$FadeIn.introd_text(Parser.load_file("introd")[0])


func _on_FadeIn_done():
	$Relogio.reset()
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()
	if semana == 0:
		$NovaMensagem.wait_time = 10
		$NovaMensagem.start()
		$Turno.wait_time = 20
	else:
		$NovaMensagem.wait_time = 30
		$NovaMensagem.start()
		$Turno.wait_time = 60
	
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
	$Turno.stop()
	
	if checar_final():
		return
	eventos()
	
	$Recebimento/Mensagem/Label.text = ""
	$Recebimento/Pedidos/PedidosManager.limpar_pedidos()
	delta_supr = 0
	for personagem in $Personagens.get_children():
		personagem.passar_turno(semana)
		if personagem.has_method("recolher_suprimento"):
			delta_supr += personagem.recolher_suprimento()
	
	atualizar_estoque(estoque_supr + delta_comp, estoque_comp + delta_supr)
	
	if semana:
		$FadeIn.turn_text()


func eventos():
	if semana == 1 and $Personagens/Weinstein.get_ordem() != "Recuar":
		$Personagens/Weinstein.receive_companhias(-2)


func checar_final():
	if semana > 6:
		return true
	
	for personagem in $Personagens.get_children():
		if personagem.has_method("get_progresso") and personagem.get_progresso() >= 3:
			return true
	
	return false

# OTHER -----------------------------------------------
func spawn_goller(alvo):
	var base
	# Encontrar base e deletar antigo
	for child in $Envio/Bases.get_children():
		if child.has_method("get_nome") and child.get_nome() == alvo:
			base = child
			for personagem in $Personagens.get_children():
				if personagem.get_nome() == base.get_nome():
					personagem.queue_free()
	
	# Spawnar Goller
	var new = goller.instance()
	$Personagens.add_child(new)
	new.connect("enviar_pedido", self, "novo_pedido")
	base.set_personagem(new)
	new.set_base(base.get_path())
	new.set_cripto(base.get_criptografia())


func add_option(option):
	$Envio/Painel/PainelTexto.add_option(option)

# SIGNAL HANDLING -------------------------------------------
func _on_Encerrar_button_up():
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
	for child in $Personagens.get_children():
		if child.get_nome() == nome_atual:
			child.receive_message(msg_atual)

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
