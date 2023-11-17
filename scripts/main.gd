extends Node2D

# TODO: Handle Top level scene changes and whatnot

func _ready():
	GameEvents.player_touched_obsticle.connect(_on_player_hit_obsticle)

func _on_player_hit_obsticle():
	print("GAME OVER")
