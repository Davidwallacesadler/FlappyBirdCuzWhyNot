extends Node2D

@export var sound_effect_audio_player: AudioStreamPlayer

var _score_sound = preload("res://assets/score_2.wav")
var _game_over_sound = preload("res://assets/splat.wav")

func _ready():
	GameEvents.player_passed_obsticle.connect(_on_passed_obsticle)
	GameEvents.game_over.connect(_on_game_over)
	

func _on_passed_obsticle() -> void:
	sound_effect_audio_player.stream = _score_sound
	sound_effect_audio_player.play()
	

func _on_game_over() -> void:
	sound_effect_audio_player.stream = _game_over_sound
	sound_effect_audio_player.play()
