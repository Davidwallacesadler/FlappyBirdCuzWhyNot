extends Node2D

@export var spawn_time: float = 3.0
@export var count: int = 4

var _obsticle_scene = preload("res://scenes/obsticle.tscn")

var timer: Timer

func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.wait_time = spawn_time
	timer.timeout.connect(_on_spawn_timer_finished)
	add_child(timer)
	_add_obsticle()

func _on_spawn_timer_finished() -> void:
	_add_obsticle()
	if (count == 0):
		timer.stop()

func _add_obsticle() -> void:
	add_child(_obsticle_scene.instantiate())
	count -= 1
	
