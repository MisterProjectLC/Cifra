extends Control

var nome_atual = ""
var suprimentos = 0
var max_suprimentos = 0
var companhias = 0
var max_companhias = 0

var mensagens = ["Nulo", "Atacar", "Recuar", "Saquear", "Interrogação"]
var mensagem_textos = ["...", "Avance contra as tropas inimigas.", 
						"Recue para uma posição segura.",
						"Faça ataques controlados para roubar suprimentos.",
						"Reporte para o Sr. Laurson.\n[Acusar de ser o Traidor.]"]
var msg_atual = 0

signal envio

func _ready():
	atualizar_mensagem(0)


func base_examined(nome, local):
	$Titulo.text = (nome + ", " + local).to_upper()
	nome_atual = nome
	atualizar_dados(0, 0)
	atualizar_mensagem(0)


func atualizar_maximo(estoque_supr, estoque_comp):
	max_suprimentos = estoque_supr
	max_companhias = estoque_comp


func atualizar_mensagem(msg):
	msg_atual = msg
	$NomeMsg.text = mensagens[msg]
	$TextoMsg/Label.text = mensagem_textos[msg]


func atualizar_dados(new_r, new_d):
	if 0 <= new_r and new_r <= max_suprimentos:
		suprimentos = new_r
	if 0 <= new_d and new_d <= max_companhias:
		companhias = new_d
	
	$Dados.text = str(suprimentos) + "x Suprimentos\n" + str(companhias) + "x Companhias"


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
	atualizar_dados(suprimentos-1, companhias)

func _on_MaisRacao_button_up():
	atualizar_dados(suprimentos+1, companhias)

# Destacamentos
func _on_MenosDestac_button_up():
	atualizar_dados(suprimentos, companhias-1)

func _on_MaisDestac_button_up():
	atualizar_dados(suprimentos, companhias+1)

# Enviar
func _on_Enviar_button_up():
	emit_signal("envio", nome_atual, suprimentos, companhias, msg_atual)
	atualizar_dados(0, 0)
