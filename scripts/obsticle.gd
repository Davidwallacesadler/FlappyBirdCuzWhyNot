extends Node2D

@export var window_size: float = 50
@export var max_height: float = 200

func _ready():
	var window_start_position = _get_window_start()
	print("Window start", window_start_position)
	_setup_top_obsticle(window_start_position)
	_setup_bottom_obsticle(max_height - (window_start_position + window_size))
	

func _get_window_start() -> float:
	var start = 0.0
	var end = max_height - window_size
	var rng = RandomNumberGenerator.new()
	return rng.randf_range(start, end)
	

func _setup_top_obsticle(height: float):
	$TopArea/CollisionShape2D.shape.size.y = height
	var y_offset_position = height * 0.5
	$TopArea.position = Vector2(0, y_offset_position)
	print("Top position: ", $TopArea.position, "Height: ", height)
	

func _setup_bottom_obsticle(height: float):
	$BottomArea/CollisionShape2D.shape.size.y = height
	var y_offset_position = max_height - (height * 0.5)
	$BottomArea.position = Vector2(0, y_offset_position)
	print("Bottom position: ", $BottomArea.position, "Height: ", height)
	
