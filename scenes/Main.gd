extends Control

var modo_envio = false

var estoque_supr = 5
var estoque_comp = 30

var semana = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	atualizar_estoque(5, 30)
	novo_pedido("Tracker, Rickville", "cesar7", "AJUDA! ENVIE AJUDA!")
	novo_pedido("Ricardo, Denvir", "morse", "Estamos quase vencendo! Envie mais tropas!")


func atualizar_estoque(suprimentos, companhias):
	estoque_supr = suprimentos
	estoque_comp = companhias
	
	$Envio/Estoque/Label.text = ("ESTOQUE\n" + 
			str(estoque_supr) + "x Suprimentos\n" + 
			str(estoque_comp) + "x Companhias")
	
	$Envio/Painel/PainelTexto.atualizar_maximo(estoque_supr, estoque_comp)


func novo_pedido(nome, cripto, texto):
	$Recebimento/Pedidos.novo_pedido(nome, cripto, texto)

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
	atualizar_estoque(estoque_supr-suprimentos, estoque_comp-companhias)
	$Personagens.find_node(nome_atual).receive_suprimentos(suprimentos)
	$Personagens.find_node(nome_atual).receive_companhias(companhias)
	$Personagens.find_node(nome_atual).receive_message(msg_atual)
