extends ColorRect

var text_n = 0
var textos = []
var _semana = 0

signal done

func title_text(text):
	$Titulo.text = text
	$AnimationPlayer.play("Titulo")

func week_text():
	title_text("Semana " + str(_semana))

func turn_text():
	$AnimationPlayer.play("FadeIn")
	_semana += 1

func introd_text(texts):
	textos = texts
	text_n = 0
	advance_text()


func advance_text():
	if text_n < textos.size():
		$Texto.text = textos[text_n]
		text_n += 1
		$AnimationPlayer.play("Texto")
	else:
		week_text()


func _on_AnimationPlayer_animation_finished(anim_name):
	if "FadeIn" == anim_name:
		week_text()
	
	elif "Titulo" == anim_name:
		emit_signal("done")
