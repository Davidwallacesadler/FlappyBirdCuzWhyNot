extends Node2D

@export var player: Player
@export var death_area: Area2D
@export var obsticle_spawner: ObsticleSpawner
@export var obsticle_reset_area: Area2D

@export var score_label: Label
@export var high_score_label: Label
@export var reset_menu: Control
@export var reset_button: Button

var _obsticle_spawner_scene = preload("res://scenes/obsticle_spawner.tscn")

var score = 0
var high_score = 0

func _ready():
	GameEvents.player_passed_obsticle.connect(_on_player_passed_obsticle)
	GameEvents.game_over.connect(_on_game_over)
	
	score_label.text = _int_to_string(score)
	death_area.body_entered.connect(_on_death_area_entered)
	reset_button.pressed.connect(_on_reset_pressed)
	

func _on_death_area_entered(body: Node2D) -> void:
	GameEvents.game_over.emit()
	

func _on_player_passed_obsticle() -> void:
	score += 1
	score_label.text = _int_to_string(score)
	

func _int_to_string(integer: int) -> String:
	var format_string = "%s"
	return format_string % integer
	

func _on_game_over() -> void:
	reset_menu.visible = true
	if score > high_score:
		high_score = score
	score = 0
	high_score_label.text = "High Score: " + _int_to_string(high_score)

# TODO: Clean this up... this is so ugly
func _on_reset_pressed() -> void:
	player.position = Vector2.ZERO
	player.reset()
	
	remove_child(obsticle_spawner)
	obsticle_spawner.queue_free()
	obsticle_spawner = _obsticle_spawner_scene.instantiate()
	obsticle_spawner.position = Vector2(get_window().size.x + 100, 0)
	add_child(obsticle_spawner)
	
	Obsticle.speed = 150
	
	reset_menu.visible = false
	score_label.text = _int_to_string(0)
 
