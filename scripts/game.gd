extends Node2D

@export var death_area: Area2D

func _ready():
	death_area.body_entered.connect(_on_death_area_entered)

func _on_death_area_entered(body: Node2D):
	print("Game Over")
	GameEvents.player_touched_obsticle.emit()
