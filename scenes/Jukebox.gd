extends Node

export var game_themes = [[]]
var semana = 0
var song_count = 0
var old_volume = 0
export(AudioStream) var wellmeetagain

func _ready():
	Audio.connect("finished", self, "finished")

func play(week):
	old_volume = Audio.get_music_volume()
	semana = week
	song_count = 0
	Audio.play_music(game_themes[semana][0])


func cease(new):
	if new:
		Audio.set_music_volume(0)
	else:
		Audio.set_music_volume(old_volume)


func finished():
	song_count += 1
	if song_count < game_themes[semana].size():
		Audio.play_music(game_themes[semana][song_count])
	else:
		Audio.play_music(game_themes[semana][0])
