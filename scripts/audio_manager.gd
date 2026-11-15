extends Node
class_name AudioManager

# Global audio manager singleton

# Audio streams (will be loaded dynamically)
var background_music: AudioStream
var engine_sound: AudioStream
var horn_sound: AudioStream
var pickup_sound: AudioStream
var dropoff_sound: AudioStream

# Audio players
var music_player: AudioStreamPlayer
var sfx_players: Array = []

# Settings
@export var music_volume: float = -10.0
@export var sfx_volume: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create music player
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.volume_db = music_volume
	music_player.autoplay = false
	
	# Create SFX players pool
	for i in range(10):
		var player = AudioStreamPlayer.new()
		add_child(player)
		player.volume_db = sfx_volume
		sfx_players.append(player)

# Play background music
func play_background_music() -> void:
	if background_music:
		music_player.stream = background_music
		music_player.play()

func stop_background_music() -> void:
	music_player.stop()

func set_background_music_volume(volume_db: float) -> void:
	music_volume = volume_db
	music_player.volume_db = music_volume

# Play sound effect
func play_sfx(sound: AudioStream) -> void:
	if sound == null:
		return
	
	# Find available player
	for player in sfx_players:
		if not player.playing:
			player.stream = sound
			player.play()
			return
	
	# If all players are busy, use the first one
	if sfx_players.size() > 0:
		sfx_players[0].stream = sound
		sfx_players[0].play()

func set_sfx_volume(volume_db: float) -> void:
	sfx_volume = volume_db
	for player in sfx_players:
		player.volume_db = sfx_volume

# Load sounds
func load_sounds() -> void:
	# These would be loaded from files
	# background_music = load("res://assets/sounds/background.mp3")
	# engine_sound = load("res://assets/sounds/engine.wav")
	# horn_sound = load("res://assets/sounds/horn.wav")
	# pickup_sound = load("res://assets/sounds/pickup.wav")
	# dropoff_sound = load("res://assets/sounds/dropoff.wav")
	pass
