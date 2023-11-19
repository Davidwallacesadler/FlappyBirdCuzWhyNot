extends Node2D

const _game_scene = preload("res://scenes/game.tscn")

func _ready():
	GameEvents.quit_game.connect(_on_quit)
	GameEvents.new_game.connect(_on_new_game)

func _on_quit() -> void:
	self.get_tree().quit()

func _on_new_game() -> void:
	self.get_tree().change_scene_to_packed(_game_scene)
