extends ColorRect

export var normal_color = "faecd4"
export var hover_color = "f7f1e7"
var active = false

signal clicked

func set_color(new):
	color = Color(new)

func _on_Notas_mouse_entered():
	set_color(hover_color)

func _on_Notas_mouse_exited():
	set_color(normal_color)


func _on_Notas_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		active = !active
		Audio.play_sound(Audio.paper)
		emit_signal("clicked", active)
