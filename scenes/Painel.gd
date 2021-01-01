extends Control

var nome_atual = ""
var criptografia_atual = "cesar3"
var suprimentos = 0
var max_suprimentos = 0
var companhias = 0
var max_companhias = 0

var mensagens = ["Nulo", "Atacar", "Recuar", "Saquear", "Insistir", "Amor"]
var mensagem_textos = {"Nulo":"...", "Atacar":"Avance contra o inimigo.", 
						"Recuar":"Recue para uma posicao segura.",
						"Saquear":"Roube suprimentos.",
						"Aviso":"Fuja. Laurson te procura.",
						"Insistir":"Isso e mandatorio, soldado.",
						"Amor":"Sei de seu amor secreto."}
var explicacao = {"Nulo":"", "Atacar":"[Perde soldados, avanca posicao.]", 
						"Recuar":"[Evita perdas, perde posicao.]",
						"Saquear":"[Perde soldados, mas base não precisa de recursos este turno.]",
						"Aviso":"[\"Eu sei que você é o traidor. Fuja. Laurson te procura.\"]",
						"Insistir":"[\"Insiste na mensagem que enviou neste dia.\"]",
						"Amor":"[\"Eu sei de seu amor secreto.\"]"}
var msg_atual = 0

var suspeitos = ["Weinstein", "Shelberg", "Mish", "Bardon"]
var texto_espiao = "Encontrei o Traidor."

var opcoes = mensagens

signal envio_mensagem
signal envio_recursos

func _ready():
	atualizar_mensagem(0)


func add_option(msg):
	mensagens.append(msg)

func remove_option(msg):
	mensagens.erase(msg)


func base_examined(nome, local, cripto):
	if local != "":
		$Titulo.text = (nome + ", " + local).to_upper()
		$Recursos.visible = true
		opcoes = mensagens
	else:
		$Titulo.text = nome.to_upper()
		$Recursos.visible = false
		opcoes = suspeitos
	
	visible = true
	nome_atual = nome
	criptografia_atual = cripto
	atualizar_dados(0, 0)
	atualizar_mensagem(0)


func atualizar_maximo(estoque_supr, estoque_comp):
	max_suprimentos = estoque_supr
	max_companhias = estoque_comp


func atualizar_mensagem(msg):
	msg_atual = msg
	
	if $Recursos.visible:
		$Mensagem/NomeMsg.text = mensagens[msg_atual]
		$Mensagem/TextoMsg/Texto.text = Codificador.codificar(mensagem_textos[mensagens[msg_atual]], criptografia_atual)
		$Mensagem/TextoMsg/Explicacao.text = explicacao[mensagens[msg_atual]]
	else:
		$Mensagem/NomeMsg.text = suspeitos[msg_atual]
		$Mensagem/TextoMsg/Texto.text = Codificador.codificar(texto_espiao, criptografia_atual)
		$Mensagem/TextoMsg/Explicacao.text = "[" + texto_espiao + "]"


func atualizar_dados(new_r, new_d):
	if 0 <= new_r and new_r <= max_suprimentos:
		suprimentos = new_r
	if 0 <= new_d and new_d <= max_companhias:
		companhias = new_d
	
	$Recursos/Dados.text = str(suprimentos) + "x Suprimentos\n" + str(companhias) + "x Companhias"


# BOTOES ----------------------------------------
# Mensagens
func _on_AntMensagem_button_up():
	if msg_atual <= 0:
		atualizar_mensagem(opcoes.size()-1)
	else:
		atualizar_mensagem(msg_atual-1)

func _on_ProxMensagem_button_up():
	if msg_atual >= opcoes.size()-1:
		atualizar_mensagem(0)
	else:
		atualizar_mensagem(msg_atual+1)

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
	emit_signal("envio_mensagem", nome_atual, opcoes[msg_atual])
	atualizar_mensagem(0)
