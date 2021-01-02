extends AudioStreamPlayer

var master_volume = 0.75
var music_volume = 0.5
var sound_volume = 0.5

export(AudioStream) var menu_theme
export(AudioStream) var rain

export var typewriter = []
export var switch = []
export var button = []
export var button2 = []
export var pause = []
export(AudioStream) var credits_theme

var players = []

func _ready():
	players = $Sounds.get_children()
	

func set_pause_music(new):
	stream_paused = new


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


func set_music_volume(new):
	music_volume = new
	volume_db = linear2db(new)

func set_sound_volume(new):
	sound_volume = new
	$Background.volume_db = linear2db(new)
