extends Control

export(PackedScene) var pedido
var revelado_count = 0

signal pedido_acessado

func _process(_delta):
	for i in range(min(revelado_count, get_child_count())):
		get_child(i).margin_top = 0.9*get_child(i).margin_top + 0.1*(11 + 55*i)
		get_child(i).margin_bottom = 0.9*get_child(i).margin_bottom + 0.1*(57 + 55*i)


func limpar_pedidos():
	revelado_count = 0
	for child in get_children():
		child.queue_free()


func novo_pedido(nome, cripto, texto, prioridade = 0):
	var new = pedido.instance()
	new.setup(nome, cripto, texto, prioridade)
	new.connect("pedido_acessado", self, "pedido_acessado")
	
	add_child(new)
	new.margin_left = 8
	new.margin_top = 800
	new.margin_bottom = 847
	
	var i = 0
	for child in get_children():
		if !child.has_method("get_prioridade") or prioridade < child.get_prioridade():
			i += 1
			continue
		move_child(new, i)
		break


func revelar_pedido():
	revelado_count += 1


func pedido_acessado(cripto, texto):
	emit_signal("pedido_acessado", cripto, texto)
