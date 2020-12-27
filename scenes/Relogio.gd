extends ColorRect

var timer = 0
var clock = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	relogio(delta)


func relogio(delta):
	timer += delta
	if timer < 1:
		return
	
	timer = 0
	clock += 1
	var horas = clock/60
	var minutos = clock%60
	if horas < 10:
		$Label.text = "0"
	else:
		$Label.text = ""
	$Label.text += str(horas)
	if minutos < 10:
		$Label.text += ":0"
	else:
		$Label.text += ":"
	$Label.text += str(minutos)
