extends Control

var nome_atual = ""
var criptografia_atual = "cesar3"
var suprimentos = 0
var max_suprimentos = 0
var companhias = 0
var max_companhias = 0

var mensagens = ["Nulo", "Atacar", "Recuar", "Saquear", "Interrogação"]
var mensagem_textos = ["...", "Avance contra o inimigo.", 
						"Recue para uma posicao segura.",
						"Roube suprimentos.",
						"Reporte para o Sr. Laurson."]
var explicacao = ["", "[Perde soldados, progresso na guerra.]", 
						"[Evita perdas, perde progresso na guerra.]",
						"[Perde soldados, mas base não precisa de recursos este turno.]",
						"[Acusar de ser o Traidor.]"]
var msg_atual = 0

signal envio_mensagem
signal envio_recursos

func _ready():
	atualizar_mensagem(0)


func base_examined(nome, local, cripto):
	$Titulo.text = (nome + ", " + local).to_upper()
	nome_atual = nome
	criptografia_atual = cripto
	atualizar_dados(0, 0)
	atualizar_mensagem(0)


func atualizar_maximo(estoque_supr, estoque_comp):
	max_suprimentos = estoque_supr
	max_companhias = estoque_comp


func atualizar_mensagem(msg):
	msg_atual = msg
	$NomeMsg.text = mensagens[msg]
	$TextoMsg/Texto.text = Codificador.codificar(mensagem_textos[msg], criptografia_atual)
	$TextoMsg/Explicacao.text = explicacao[msg]

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
func _on_EnviarRecursos_button_up():
	emit_signal("envio_recursos", nome_atual, suprimentos, companhias)
	atualizar_dados(0, 0)

func _on_EnviarMensagem_button_up():
	emit_signal("envio_mensagem", nome_atual, msg_atual)
	atualizar_mensagem(0)
