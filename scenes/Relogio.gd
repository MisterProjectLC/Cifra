extends Control

var clock = 0

# Relogio em si -------------
func relogio():
	clock += 1
	# Horas
	var horas = 8 + clock/60
	if horas < 10:
		$Label.text = "0"
	else:
		$Label.text = ""
	$Label.text += str(horas)
	
	# Minutos
	var minutos = clock%60
	if minutos < 10:
		$Label.text += ":0"
	else:
		$Label.text += ":"
	$Label.text += str(minutos)


func reset():
	clock = 0
	$Label.text = "10:00"
