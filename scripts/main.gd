extends Node2D

# TODO: Handle Top level scene changes and whatnot

func _ready():
	GameEvents.game_over.connect(_on_game_over)

func _on_game_over():
	print("GAME OVER")
