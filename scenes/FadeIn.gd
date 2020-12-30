extends ColorRect

var text_n = 0
var textos = []

signal done

func week_text(semana):
	$Semana.text = "Semana " + str(semana)
	$AnimationPlayer.play("Semana")


func turn_text(semana):
	$AnimationPlayer.play("FadeIn")
	week_text(semana)


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
		week_text(0)


func _on_AnimationPlayer_animation_finished(anim_name):
	if "Semana" == anim_name:
		emit_signal("done")
