extends Node2D

@export var death_area: Area2D
@export var score_label: Label

var score = 0

func _ready():
	score_label.text = _int_to_string(score)
	death_area.body_entered.connect(_on_death_area_entered)
	
	GameEvents.player_passed_obsticle.connect(_on_player_passed_obsticle)

func _on_death_area_entered(body: Node2D) -> void:
	print("Game Over")
	GameEvents.player_touched_obsticle.emit()

func _on_player_passed_obsticle() -> void:
	score += 1
	score_label.text = _int_to_string(score)
	

func _int_to_string(integer: int) -> String:
	var format_string = "%s"
	return format_string % integer
