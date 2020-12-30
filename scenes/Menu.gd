extends Control

var messages

var message1 = ""
var message2 = ""
var progress = 0
var already = 0

signal start_game

# MESSAGES -------------------------------------------------------
func _ready():
	randomize()
	messages = Parser.load_file("menu")[0]
	_on_Swap_timeout()

func _process(_delta):
	$Mensagens/Label.text = message1.substr(0, progress)
	$Mensagens/Label2.text = message2.substr(0, progress)

func _on_Timer_timeout():
	progress += 1


func _on_Swap_timeout():
	if !already:
		message1 = "\"" + messages[randi() % messages.size()] + "\""
		progress = 0
	else:
		progress = message1.length()
		message1 += "\n\"" + messages[randi() % messages.size()] + "\""
	
	message2 = Codificador.codificar(message1, "cesar3")
	already += 1
	if already > 2:
		already = 0


# BUTTONS ---------------------------------------------
func _on_Jogar_button_up():
	$AnimationPlayer.play("MenuFadeIn")

func _on_AnimationPlayer_animation_finished(_anim_name):
	visible = false
	emit_signal("start_game")

func _on_Sair_button_up():
	get_tree().quit()
