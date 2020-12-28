extends Button

export var nome = "Wilhelm"
export var local = "Kleinburg"

signal base_examined

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = nome + ", " + local

func _on_Base_button_up():
	emit_signal("base_examined", nome, local)

func get_nome():
	return nome
