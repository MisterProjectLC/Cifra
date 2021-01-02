extends Control

var clock_max = 30
var intervalo = 15

var modo_envio = false
var notas = false
var estoque_supr
var estoque_comp
var delta_supr
export var delta_comp = 3

var lowest_priority = -1

var animacao
var semana
var final
var escaped
var denuncia
var incompetente

export(PackedScene) var goller

signal fade_in
signal text
signal title_text

# START ------------------------------------------------
func _ready():
	for personagem in $Personagens.get_children():
		personagem.connect("enviar_pedido", self, "novo_pedido")
	semana = -1
	final = -1
	escaped = false
	denuncia = false
	incompetente = false
	atualizar_estoque(0, 0)
	passar_turno()


func _on_Menu_start_game():
	animacao = 0
	emit_signal("fade_in")
	$Jukebox.play(0)


func _on_FadeIn_done():
	if final != -1:
		if animacao == 0:
			animacao = 1
			emit_signal("text", Parser.load_file("finais")[final])
		
		elif animacao == 1:
			animacao = 2
			emit_signal("title_text", "Fim")
			visible = false
		
		else:
			get_tree().change_scene("res://scenes/Main.tscn")
	
	else:
		if animacao == 0:
			animacao = 1
			emit_signal("text", Parser.load_file("introd")[0])
		
		elif animacao == 1:
			visible = true
			animacao = 2
			emit_signal("title_text", "Semana " + str(semana))
		
		elif animacao == 2:
			$Recebimento/Pedidos/PedidosManager.revelar_pedido()
			$Recebimento/Pedidos/PedidosManager.revelar_pedido()
			if semana == 0:
				$NovaMensagem.wait_time = 10
				$NovaMensagem.start()
				$Turno.wait_time = 180
			else:
				$NovaMensagem.wait_time = 30
				$NovaMensagem.start()
				$Turno.wait_time = 60*10
			
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
	lowest_priority = -1
	$Relogio.reset()
	$Timer.stop()
	$Turno.stop()
	
	final = checar_final()
	if final != -1:
		emit_signal("fade_in")
		return
	
	eventos()
	$Recebimento/Mensagem/Label.text = ""
	$Recebimento/Pedidos/PedidosManager.limpar_pedidos()
	delta_supr = 0
	for personagem in $Personagens.get_children():
		personagem.passar_turno()
		if personagem.has_method("recolher_suprimento"):
			delta_supr += personagem.recolher_suprimento()
	
	atualizar_estoque(estoque_supr + delta_supr, estoque_comp + delta_comp)
	
	if semana:
		animacao = 1
		emit_signal("fade_in")
		$Jukebox.play(semana)


func eventos():
	if semana == 1:
		if $Personagens/Weinstein.get_ordem() != "Recuar":
			$Personagens/Weinstein.receive_companhias(-2)
	
	elif semana == 3 and $Personagens/Bardon.get_ordem() == "Atacar":
		$Personagens/Hop.tarefa_feita()
	
	elif semana == 5:
		if $Personagens/Shelberg.get_ordem() == "Atacar" and $Personagens/Bardon.get_ordem() == "Atacar":
			$Personagens/Hop.tarefa_feita()
			$Personagens/Shelberg.receive_companhias(2)
			$Personagens/Bardon.receive_companhias(2)
		elif $Personagens/Shelberg.get_ordem() == "Atacar" and $Personagens/Bardon.get_ordem() != "Atacar":
			$Personagens/Shelberg.receive_companhias(-2)
		elif $Personagens/Shelberg.get_ordem() != "Atacar" and $Personagens/Bardon.get_ordem() == "Atacar":
			$Personagens/Bardon.receive_companhias(-2)


func checar_final():
	animacao = 0
	
	if semana > 6:
		return 0
	if denuncia:
		return 1
	if incompetente:
		return 2
	for personagem in $Personagens.get_children():
		if personagem.has_method("get_progresso") and personagem.get_progresso() >= 3:
			return 3
	return -1

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
	new.set_base(base.get_path())
	new.set_cripto(base.get_criptografia())
	base.set_personagem(new)


func add_option(option):
	$Envio/Painel/PainelTexto.add_option(option)

func _on_Mish_escape():
	escaped = true
	spawn_goller("Mish")

func _on_Shelberg_denuncia():
	denuncia = true

func _on_Hop_incompetente():
	incompetente = true

func _on_Weinstein_abastecido():
	$Personagens/Hop.tarefa_feita()

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
	if prioridade < 0:
		$Recebimento/Pedidos/PedidosManager.novo_pedido(nome, cripto, texto, lowest_priority)
		lowest_priority -= 1

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

func _on_Notas_button_up():
	$Recebimento.visible = !modo_envio
	$Envio.visible = modo_envio


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
	Audio.set_pause_music(true)
	get_tree().paused = true
	$AnimationPlayer.play("PauseMenu")

func _on_Continuar_button_up():
	Audio.set_pause_music(false)
	get_tree().paused = false
	$AnimationPlayer.play_backwards("PauseMenu")

func _on_Menu_button_up():
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_Sair_button_up():
	get_tree().quit()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "PauseMenu" and get_tree().paused == true:
		Audio.play_sound(Audio.pause)


func _on_Notas_clicked(active):
	if active:
		$AnimationPlayer.play("Notas")
	else:
		$AnimationPlayer.play_backwards("Notas")
