extends Control

var racoes = 0
var max_racoes = 0
var destacamentos = 0
var max_destacamentos = 0

var mensagens = ["Nulo", "Atacar"]
var mensagem_textos = ["...", "Avance contra as tropas\ninimigas."]
var msg_atual = 0

signal envio

func _ready():
	atualizar_mensagem(0)


func base_examined(base):
	$Titulo.text = base.get_nome().to_upper()
	$Dados.text = "0x Rações\n0x Destacamentos"
	atualizar_mensagem(0)


func atualizar_maximo(estoque_racoes, estoque_destac):
	max_racoes = estoque_racoes
	max_destacamentos = estoque_destac


func atualizar_mensagem(msg):
	msg_atual = msg
	$NomeMsg.text = mensagens[msg]
	$TextoMsg/Label.text = mensagem_textos[msg]


func atualizar_dados(new_r, new_d):
	if 0 <= new_r and new_r <= max_racoes:
		racoes = new_r
	
	if 0 <= new_d and new_d <= max_destacamentos:
		destacamentos = new_d
	
	$Dados.text = str(racoes) + "x Rações\n" + str(destacamentos) + "x Destacamentos"


# BOTOES ----------------------------------------

# Mensagens
func _on_AntMensagem_button_up():
	if msg_atual > 0:
		atualizar_mensagem(msg_atual-1)
	else:
		atualizar_mensagem(mensagens.size()-1)

func _on_ProxMensagem_button_up():
	if msg_atual < mensagens.size()-1:
		atualizar_mensagem(msg_atual+1)
	else:
		atualizar_mensagem(0)

# Racoes
func _on_MenosRacao_button_up():
	atualizar_dados(racoes-1, destacamentos)

func _on_MaisRacao_button_up():
	atualizar_dados(racoes+1, destacamentos)

# Destacamentos
func _on_MenosDestac_button_up():
	atualizar_dados(racoes, destacamentos-1)

func _on_MaisDestac_button_up():
	atualizar_dados(racoes, destacamentos+1)

# Enviar
func _on_Enviar_button_up():
	emit_signal("envio", racoes, destacamentos, msg_atual)
	atualizar_dados(0, 0)
