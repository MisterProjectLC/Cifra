extends "Soldado.gd"

var introducao = false
var amor = false

func tomar_acoes():
	if _suprimentos < _companhias and _companhias < 2:
		_ordem = "Saquear"
		enviar_pedido(("Idiota, voce nao enviou o que eu precisava. Soldados morreram para "+
		"nos sustentar."), 15)

func enviar_mensagens():
	if !introducao:
		enviar_pedido("Saudacoes. Sou Ashley Goller. Envie tudo o que eu precise e eu vencerei esta guerra.", 10)
		introducao = true
	
	if _suprimentos < _companhias:
		enviar_pedido(str(2*_companhias-_suprimentos) + " suprimentos. " +
		"Envie imediatamente.", 3)
		
	if _companhias < 5:
		enviar_pedido("Envie 3 companhias, no minimo. Estamos com falta de soldados.", 3)
	else:
		enviar_pedido("Podemos avancar. De a palavra e nos atacamos.", 3)



func receive_message(message):
	.receive_message(message)
	
	if message == "Amor" and !amor:
		enviar_pedido(("Amor...? Voce e um idiota, sabia? Cala a boca."), -1)
		amor = true
	
	else:
		_ordem = message


func fim():
	.fim()
	enviar_pedido(("Estamos rodeados. ...Eu perdi. " + str(local) + " caiu."), 10)
