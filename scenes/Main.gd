extends Control

var modo_envio = false

var estoque_racoes = 5
var estoque_destac = 30
var mes = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	atualizar_estoque(5, 30)
	$Codificador.morse("teste abc".to_lower())


func atualizar_estoque(racoes, destacamentos):
	estoque_racoes = racoes
	estoque_destac = destacamentos
	
	$Envio/Estoque/Label.text = ("ESTOQUE\n" + 
			str(estoque_racoes) + "x Racoes\n" + 
			str(estoque_destac) + "x Destacamentos")
	
	$Envio/Painel/PainelTexto.atualizar_maximo(estoque_racoes, estoque_destac)


func _on_Troca_button_up():
	modo_envio = !modo_envio
	$Recebimento.visible = !modo_envio
	$Envio.visible = modo_envio
	if modo_envio:
		$Troca/Label.text = "RECEBER"
	else:
		$Troca/Label.text = "ENVIO"


func base_examined(base):
	$Envio/Painel.base_examined(base)


func _on_PainelTexto_envio(racoes, destacamentos, msg_atual):
	atualizar_estoque(racoes, destacamentos)
