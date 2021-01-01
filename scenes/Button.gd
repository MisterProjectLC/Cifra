extends Button

export var label = "Jogar"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = label


func _on_Button_button_up():
	Audio.play_sound(Audio.button)
