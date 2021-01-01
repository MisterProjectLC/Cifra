extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Audio.play_rain(Audio.rain)
	Audio.play_music(Audio.menu_theme)
