extends Control

var clock_max = 30
var intervalo = 15

var modo_envio = false
var estoque_supr
var estoque_comp

var semana
var finais

# Called when the node enters the scene tree for the first time.
func _ready():
	semana = 0
	finais = Parser.load_file("finais")
	
	atualizar_estoque(0, 0)
	passar_turno()


func _on_Timer_timeout():
	$Relogio.relogio()

func _on_NovaMensagem_timeout():
	$Recebimento/Pedidos/PedidosManager.revelar_pedido()

func _on_Turno_timeout():
	passar_turno()

func passar_turno():
	semana += 1
	if checar_final():
		return
	
	$Recebimento/Pedidos/PedidosManager.limpar_pedidos()
	for personagem in $Personagens.get_children():
		personagem.passar_turno()
		if personagem.has_method("recolher_suprimento"):
			estoque_supr += personagem.recolher_suprimento()
	
	estoque_comp += 3
	atualizar_estoque(estoque_supr, estoque_comp)


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
			str(estoque_comp) + "x Companhias")
	
	$Envio/Painel/PainelTexto.atualizar_maximo(estoque_supr, estoque_comp)


func novo_pedido(nome, cripto, texto, prioridade):
	$Recebimento/Pedidos/PedidosManager.novo_pedido(nome, cripto, texto, prioridade)

func pedido_acessado(cripto, texto):
	$Recebimento/Mensagem/Label.text = $Codificador.codificar(texto, cripto)

func base_examined(nome, local):
	$Envio/Painel/PainelTexto.base_examined(nome, local)

func _on_Troca_button_up():
	modo_envio = !modo_envio
	$Recebimento.visible = !modo_envio
	$Envio.visible = modo_envio
	if modo_envio:
		$Troca/Label.text = "RECEBER"
	else:
		$Troca/Label.text = "ENVIO"

func _on_PainelTexto_envio(nome_atual, suprimentos, companhias, msg_atual):
	if $Personagens.has_node(nome_atual):
		atualizar_estoque(estoque_supr-suprimentos, estoque_comp-companhias)
		$Personagens.find_node(nome_atual).receive_suprimentos(suprimentos)
		$Personagens.find_node(nome_atual).receive_companhias(companhias)
		$Personagens.find_node(nome_atual).receive_message(msg_atual)
