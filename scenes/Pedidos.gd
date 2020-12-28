extends ColorRect

export(PackedScene) var pedido
var pedido_count = 0

signal pedido_acessado

func novo_pedido(nome, cripto, texto):
	var new = pedido.instance()
	new.setup(nome, cripto, texto)
	new.connect("pedido_acessado", self, "pedido_acessado")
	
	add_child(new)
	new.margin_left = 8
	new.margin_top = 11 + 55*pedido_count
	new.margin_bottom = 57 + 55*pedido_count
	pedido_count += 1


func pedido_acessado(cripto, texto):
	emit_signal("pedido_acessado", cripto, texto)
