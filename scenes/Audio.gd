extends AudioStreamPlayer

var master_volume = 0.75
var music_volume = 1
var sound_volume = 0.8

export(AudioStream) var menu_theme
export(AudioStream) var rain
export var typewriter = []
export var switch = []
export var button = []
export var pause = []
export(AudioStream) var credits_theme

var players = []

func _ready():
	players = $Sounds.get_children()
	

func play_music(path):
	stream = path
	playing = true
	volume_db = linear2db(music_volume*master_volume)

func stop_music():
	playing = false

func play_rain(path):
	$Background.stream = path
	$Background.playing = true
	$Background.volume_db = linear2db(music_volume*master_volume)

func play_sound(sound_list):
	var the_player = players[players.size()-1]
	for player in players:
		if !player.playing:
			the_player = player
	
	the_player.stream = sound_list[rand_range(0, sound_list.size())]
	the_player.playing = true
	the_player.volume_db = linear2db(sound_volume*master_volume)
