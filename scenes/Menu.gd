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
	if progress < message1.length():
		progress += 1
		Audio.play_sound(Audio.typewriter)


func _on_Swap_timeout():
	if !already:
		message1 = "\"" + messages[randi() % messages.size()] + "\""
		progress = 0
	else:
		message1 += "\n\"" + messages[randi() % messages.size()] + "\""
	
	message2 = Codificador.codificar(message1, "cesar3")
	already += 1
	if already > 2:
		already = 0


# BUTTONS ---------------------------------------------
func _on_Jogar_button_up():
	$Timer.stop()
	$Swap.stop()
	Audio.stop()
	emit_signal("start_game")

func _on_Opcoes_button_up():
	$Options.visible = true

func _on_Sair_button_up():
	get_tree().quit()
	Audio.play_sound(Audio.button)


func _on_SoundSlider_value_changed(value):
	Audio.set_sound_volume(value*0.01)

func _on_MusicSlider_value_changed(value):
	Audio.set_music_volume(value*0.01)

func _on_Voltar_button_up():
	$Options.visible = false


func _on_FadeIn_done():
	visible = false
