extends AudioStreamPlayer

var master_volume = 0.75
var music_volume = 0.5
var sound_volume = 0.8

export(AudioStream) var menu_theme
export(AudioStream) var victory_theme
export(AudioStream) var bittersweet_theme
export(AudioStream) var failure_theme
export(AudioStream) var rain
export(AudioStream) var staticsound

export var typewriter = []
export var thunder = []
export var loud_thunder = []
export var paper = []
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


func play_background(path, i = -1):
	var backgrounds = $Background.get_children()
	var the_player 
	if i == -1:
		the_player = backgrounds[backgrounds.size()-1]
		for player in backgrounds:
			if !player.playing:
				the_player = player
	else:
		the_player = backgrounds[i]
	
	the_player.stream = path
	the_player.playing = true
	the_player.volume_db = linear2db(sound_volume*master_volume)


func play_sound(sound_list):
	var the_player = players[players.size()-1]
	for player in players:
		if !player.playing:
			the_player = player
	
	the_player.stream = sound_list[rand_range(0, sound_list.size())]
	the_player.playing = true
	the_player.volume_db = linear2db(sound_volume*master_volume)


func stop_music():
	playing = false

func stop_background(i):
	$Background.get_child(i).playing = false


func set_music_volume(new):
	music_volume = new
	volume_db = linear2db(new)

func set_sound_volume(new):
	sound_volume = new
	$Background.get_child(0).volume_db = linear2db(new)

func get_music_volume():
	return music_volume

func get_sound_volume():
	return sound_volume
