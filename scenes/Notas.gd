extends ColorRect

export var normal_color = "faecd4"
export var hover_color = "f7f1e7"
var active = false

signal clicked

func _on_Notas_mouse_entered():
	color = Color(hover_color)

func _on_Notas_mouse_exited():
	color = Color(normal_color)


func _on_Notas_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		active = !active
		emit_signal("clicked", active)
