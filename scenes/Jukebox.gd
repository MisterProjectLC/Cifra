extends Node

export var game_themes = [[]]
var semana = 0
var song_count = 0

func _ready():
	Audio.connect("finished", self, "finished")

func play(week):
	semana = week
	song_count = 0
	Audio.play_music(game_themes[semana][0])


func finished():
	song_count += 1
	if song_count < game_themes[semana].length():
		Audio.play_music(game_themes[semana][song_count])
	else:
		Audio.play_music(game_themes[semana][0])
