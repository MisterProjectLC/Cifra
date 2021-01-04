extends Control

var clock_max = 30
var intervalo = 15
var cooldown = 0

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
signal play_speed

# START ------------------------------------------------
func _ready():
	for personagem in $Personagens.get_children():
		personagem.connect("enviar_pedido", self, "novo_pedido")
		if personagem.has_method("recolher_suprimento"):
			personagem.connect("morte", self, "morte")
	semana = -1
	final = -1
	escaped = false
	denuncia = false
	incompetente = false
	atualizar_estoque(0, 0)
	passar_turno()
	atualizar_estoque(0, 0)


func _on_Menu_start_game():
	animacao = 0
	emit_signal("fade_in")
	$Jukebox.play(0)


func _on_FadeIn_done():
	if final != -1:
		if animacao == 0:
			animacao = 1
			emit_signal("play_speed", 0.6)
			emit_signal("text", Parser.load_file("finais")[final])
		
		elif animacao == 1:
			animacao = 2
			emit_signal("title_text", "FIM")
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
				$Turno.wait_time = 180
			else:
				$NovaMensagem.wait_time = 20
				$Turno.wait_time = 60*10
			
			$NovaMensagem.start()
			$Timer.start()
			$Turno.start()


# TIMERS --------------------------------------
func _on_Timer_timeout():
	$Relogio/Relogio.relogio()
	chance_raio()

func _on_NovaMensagem_timeout():
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()

func _on_Turno_timeout():
	passar_turno()

# RAIO ----------------------------------------
func chance_raio():
	if randi() % 140 == 0 and cooldown <= 0:
		cooldown = 6
		if semana >= 4 and randi() % (10-semana) == 0:
			Audio.play_sound(Audio.loud_thunder)
			Audio.play_background(Audio.staticsound, 1)
			set_raio(true)
			$Thunder.wait_time = 5 + (randi() % 10)
			$Thunder.start()
		else:
			Audio.play_sound(Audio.thunder)
	elif cooldown > 0:
		cooldown -= 1


func set_raio(new):
	if new:
		$AnimationPlayer.play("Lightning")
	else:
		Audio.stop_background(1)
	$Jukebox.cease(new)


func _on_Thunder_timeout():
	set_raio(false)

# PASSAR TURNO -------------------------------------------
func passar_turno():
	semana += 1
	lowest_priority = -1
	$Relogio/Relogio.reset()
	$Timer.stop()
	$Turno.stop()
	
	eventos()
	$Recebimento/Mensagem/Label.text = ""
	$Recebimento/Pedidos/PedidosManager.limpar_pedidos()
	delta_supr = 0
	for personagem in $Personagens.get_children():
		personagem.passar_turno()
		if personagem.has_method("recolher_suprimento"):
			delta_supr += personagem.recolher_suprimento()
	
	atualizar_estoque(estoque_supr + delta_supr, estoque_comp + delta_comp)
	
	final = checar_final()
	if final != -1:
		emit_signal("fade_in")
		return
	
	if semana:
		animacao = 1
		emit_signal("fade_in")
		$Jukebox.play(semana)


func eventos():
	if semana == 1:
		if $Personagens/Weinstein.get_ordem() != "Recuar":
			$Personagens/Weinstein.receive_companhias(-2)
	
	elif semana == 2 and $Personagens/Weinstein.get_ordem() == "Atacar":
		$Personagens/Hop.fazer_tarefa()
	
	elif semana == 3 and $Personagens/Bardon.get_ordem() == "Atacar":
		$Personagens/Hop.fazer_tarefa()
	
	elif semana == 5:
		if $Personagens/Shelberg.get_ordem() == "Atacar" and $Personagens/Bardon.get_ordem() == "Atacar":
			$Personagens/Hop.fazer_tarefa()
			$Personagens/Shelberg.receive_companhias(2)
			$Personagens/Bardon.receive_companhias(2)
		elif $Personagens/Shelberg.get_ordem() == "Atacar" and $Personagens/Bardon.get_ordem() != "Atacar":
			$Personagens/Shelberg.receive_companhias(-2)
		elif $Personagens/Shelberg.get_ordem() != "Atacar" and $Personagens/Bardon.get_ordem() == "Atacar":
			$Personagens/Bardon.receive_companhias(-2)
	
	elif semana == 6:
		if escaped:
			$Personagens/Laurson.sos()


func checar_final():
	animacao = 0
	# Final venceu
	for personagem in $Personagens.get_children():
		if personagem.has_method("get_progresso") and personagem.get_progresso() >= 3:
			if !escaped:
				Audio.play_music(Audio.victory_theme)
				return 0
			else:
				Audio.play_music(Audio.bittersweet_theme)
				return 1
	# Final dizimado
	var count = 0
	for personagem in $Personagens.get_children():
		if personagem.has_method("get_progresso") and personagem.get_progresso() <= -1:
			count += 1
	if count >= 3:
		if !escaped:
			Audio.play_music(Audio.failure_theme)
			return 2
		else:
			Audio.play_music(Audio.bittersweet_theme)
			return 3
	# Final bombardeio
	if semana > 6:
		if !escaped:
			Audio.play_music(Audio.failure_theme)
			return 4
		else:
			Audio.play_music(Audio.bittersweet_theme)
			return 5
	# Denunciado por Shelberg
	if denuncia:
		Audio.play_music(Audio.bittersweet_theme)
		return 6
	# Demitido por Hop
	if incompetente:
		Audio.play_music(Audio.bittersweet_theme)
		return 7
	return -1

# OTHER -----------------------------------------------
func spawn_goller(alvo):
	$Envio/Painel/PainelTexto.remove_option("Aviso")
	$Personagens/Laurson.traidor_saiu()
	if escaped:
		return
		
	$Personagens/Hop.enviar_goller()
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


# SIGNAL HANDLING -------------------------------------------
# STORY SIGNALS ---------------
func add_option(option):
	$Envio/Painel/PainelTexto.add_option(option)

func morte(local):
	$Personagens/Hop.base_caiu(local)
	$Personagens/Laurson.base_caiu(local)

func _on_Mish_escape():
	spawn_goller("Mish")
	escaped = true
	$Personagens/Bardon.sos()
	$Personagens/Laurson.sos()

func _on_Shelberg_denuncia():
	denuncia = true

func _on_Hop_incompetente():
	incompetente = true

func _on_Weinstein_abastecido():
	if semana >= 5:
		$Personagens/Hop.fazer_tarefa()

func _on_Weinstein_disco():
	$Jukebox.game_themes[5][0] = $Jukebox.wellmeetagain


# GAME SIGNALS ----------------------
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
	if prioridade < 0:
		$Recebimento/Pedidos/PedidosManager.novo_pedido(nome, cripto, texto, lowest_priority)
		lowest_priority -= 1
	else:
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
		$Personagens.get_node(nome_atual).receive_suprimentos(suprimentos)
		$Personagens.get_node(nome_atual).receive_companhias(companhias)


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
