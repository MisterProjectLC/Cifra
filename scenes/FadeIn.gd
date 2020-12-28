extends ColorRect

var fading = true
var speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !visible:
		return
	
	if fading:
		if modulate.a > 0:
			modulate.a -= delta*speed
	else:
		if modulate.a < 1:
			modulate.a += delta*speed
