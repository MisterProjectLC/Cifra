extends ColorRect

var text_n = 0
var textos = []
var next_anim = ""

signal done

# APPLIED -----------------------
func fade_in():
	$AnimationPlayer.play("FadeIn")

func title_text(text):
	$Titulo.text = text
	$AnimationPlayer.play("Titulo")

func text(texts):
	textos = texts
	text_n = 0
	advance_text()

# BUILDING BLOCKS ------------------------
func advance_text():
	if text_n < textos.size():
		$Texto.text = textos[text_n]
		text_n += 1
		$AnimationPlayer.play("Texto")
	else:
		emit_signal("done")


# ON FINISHED ------------------------
func _on_AnimationPlayer_animation_finished(anim_name):
	if "Texto" != anim_name:
		emit_signal("done")
	else:
		advance_text()


func set_speed_scale(scale):
	$AnimationPlayer.set_speed_scale(scale)
