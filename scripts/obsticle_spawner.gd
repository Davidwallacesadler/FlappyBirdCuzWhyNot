class_name ObsticleSpawner extends Node2D

@export var spawn_time: float = 2.0
@export var obsticle_count: int = 4

var _obsticle_scene = preload("res://scenes/obsticle.tscn")

var _spawn_timer: Timer
var _obsticles: Array[Node2D] = []

func _ready():
	_spawn_timer = Timer.new()
	_spawn_timer.autostart = true
	_spawn_timer.wait_time = spawn_time
	_spawn_timer.timeout.connect(_on_spawn_timer_finished)
	
	self.add_child(_spawn_timer)
	_add_obsticle()
	

func _on_spawn_timer_finished() -> void:
	_add_obsticle()
	if (_obsticles.size() == obsticle_count):
		_spawn_timer.stop()
	

func _add_obsticle() -> void:
	var obsticle = _obsticle_scene.instantiate()
	self.add_child(_obsticle_scene.instantiate())
	_obsticles.append(obsticle)
	

#func reset() -> void:
#	for obsticle in _obsticles:
#		obsticle.queue_free()
##		self.remove_child(obsticle)
#	_add_obsticle()
#	_spawn_timer.start()
	
