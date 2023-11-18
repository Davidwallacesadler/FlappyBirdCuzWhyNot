extends Node2D

@export var spawn_time: float = 3.0
@export var count: int = 5

var _obsticle_scene = preload("res://scenes/obsticle.tscn")

var timer: Timer

func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.wait_time = spawn_time
	timer.timeout.connect(_on_spawn_timer_finished)
	add_child(timer)

func _on_spawn_timer_finished() -> void:
	add_child(_obsticle_scene.instantiate())
	count -= 1
	if (count == 0):
		timer.stop()
