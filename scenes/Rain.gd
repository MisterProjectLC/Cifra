extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Audio.play_background(Audio.rain, 0)
	Audio.play_music(Audio.menu_theme)
