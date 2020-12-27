extends Button

export var nome = "Wilhelm, Kleinburg"
var _racoes = 0
var _destacamentos = 0

signal base_examined

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = nome


func _on_Base_button_up():
	emit_signal("base_examined", self)


func get_nome():
	return nome

func get_racoes():
	return _racoes

func get_destacamentos():
	return _destacamentos
